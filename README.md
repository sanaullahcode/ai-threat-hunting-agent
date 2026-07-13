<div align="center">

# AI Threat Hunting & Threat Intelligence Agent

**An autonomous analyst that hunts newly published CVEs, triages them by real-world risk, and writes the daily threat report before your SOC team even logs in.**

Built by **Sana Ullah**

[![Python](https://img.shields.io/badge/Python-3.10%2B-3776AB?logo=python&logoColor=white)](https://www.python.org/)
[![NVD API](https://img.shields.io/badge/Data%20Source-NVD%20API%20v2.0-1F6FEB)](https://nvd.nist.gov/developers)
[![Claude API](https://img.shields.io/badge/LLM-Claude%20API-D97757)](https://www.anthropic.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

</div>

---

## Why this exists

Hundreds of CVEs are published every week and no analyst can read every
advisory in full. This agent does the first pass automatically: it pulls
what is new, ranks it by actual severity and exploitation signal, and hands
back a short report that tells a SOC team exactly what needs attention
today instead of a raw, unranked feed.

## How it works

```
   NVD API v2.0
        │  fetch CVEs published in the last N days
        ▼
 ┌────────────────┐
 │  nvd_client.py │
 └───────┬────────┘
         │  raw CVE list
         ▼
 ┌────────────────┐   CVSS score + exploitation keywords
 │  cve_scorer.py │ ─────────────────────────────────────▶  Critical / High / Medium / Low
 └───────┬────────┘
         │  top priority CVEs
         ▼
 ┌────────────────┐
 │ threat_agent.py│ ───▶  Claude API  ───▶  daily threat report (terminal + JSON)
 └────────────────┘
```

## Core capabilities

| Capability | Detail |
|---|---|
| Collection | Pulls newly published CVEs directly from NVD, no scraping |
| Triage | Priority banding driven by CVSS base score |
| Exploitation signal | Flags descriptions mentioning active exploitation or public PoCs |
| Reporting | Claude writes an executive summary, detection guidance, and mitigation steps |
| Record keeping | Every run is saved as a timestamped JSON report |

## Ask it

```
What are today's most dangerous vulnerabilities?
```

## Example output

```
$ python src/threat_agent.py

┌──────────────┬──────┬──────────┬─────────────────────────────┐
│ CVE ID       │ CVSS │ Priority │ Exploitation Signal          │
├──────────────┼──────┼──────────┼─────────────────────────────┤
│ CVE-2026-XXXX│ 9.8  │ Critical │ Likely high risk (keyword)   │
│ CVE-2026-XXXX│ 7.5  │ High     │ No strong exploitation signal│
└──────────────┴──────┴──────────┴─────────────────────────────┘

Daily Threat Report
Two critical vulnerabilities were published in the last 24 hours affecting
remote authentication services. Both show indicators consistent with early
exploitation attempts...
```

## Project structure

```
ai-threat-hunting-agent/
├── src/
│   ├── threat_agent.py   # CLI entry point
│   ├── nvd_client.py     # NVD API client
│   └── cve_scorer.py     # priority banding and exploitation heuristic
├── reports/               # generated daily threat reports
├── tests/
│   └── test_cve_scorer.py
├── requirements.txt
└── .env.example
```

## Setup

```bash
git clone https://github.com/sanaullahcode/ai-threat-hunting-agent.git
cd ai-threat-hunting-agent
pip install -r requirements.txt
cp .env.example .env
```

Add your keys inside `.env`:

```
ANTHROPIC_API_KEY=your_key_here
NVD_API_KEY=optional_but_removes_strict_rate_limiting
```

## Usage

Run a standard daily hunt:

```bash
python src/threat_agent.py
```

Look further back and pull more results:

```bash
python src/threat_agent.py --days 3 --limit 15
```

## Testing

```bash
pytest tests/
```

## Design decisions

**CVSS score drives priority, keywords only add a signal.** The banding
logic is anchored to the standardized CVSS base score so results stay
consistent and defensible, while the exploitation keyword check is treated
as a secondary flag, not the primary ranking factor.

**Offline fallback by default.** If no Claude API key is set, the agent
still produces a usable rule-based summary instead of failing outright, so
the triage table remains useful on its own.

## Roadmap

- [ ] MISP feed integration for community threat intelligence
- [ ] Shodan integration to check internet exposure of vulnerable services
- [ ] Scheduled daily run with Slack or email delivery of the report
- [ ] Historical trend view across saved JSON reports

## License

Released under the [MIT License](LICENSE).

## Author

**Sana Ullah**
BS Software Engineering, FUUAST Islamabad
Focus areas: Cybersecurity, AI/ML, Software Engineering
GitHub: [sanaullahcode](https://github.com/sanaullahcode)
