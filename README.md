# AI Threat Hunting & Threat Intelligence Agent

Built by **Sana Ullah**

An autonomous AI analyst that pulls newly published CVEs from the National
Vulnerability Database, triages them by severity and exploitation signal,
and produces a daily threat report a SOC team can act on immediately.

## What it does

- Fetches recently published CVEs from the NVD API v2.0
- Scores each CVE into Critical, High, Medium, or Low priority bands
- Flags likely-exploited vulnerabilities using description keyword signals
- Uses Claude to generate a daily threat report: executive summary,
  detection guidance, and mitigation recommendations
- Saves every report as JSON for historical tracking

## Ask it

```
What are today's most dangerous vulnerabilities?
```

## Tech stack

- Python 3.10+
- NVD API v2.0
- Anthropic Claude API
- Rich (terminal tables and formatting)

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
# add ANTHROPIC_API_KEY inside .env
# NVD_API_KEY is optional but removes strict rate limiting
```

## Usage

```bash
python src/threat_agent.py
```

Look further back and pull more results:

```bash
python src/threat_agent.py --days 3 --limit 15
```

## Running tests

```bash
pytest tests/
```

## Roadmap

- MISP feed integration for community threat intelligence
- Shodan API integration to check internet exposure of vulnerable services
- Scheduled daily run with Slack or email delivery of the report

## Author

Sana Ullah — BS Software Engineering, FUUAST Islamabad
Focus areas: Cybersecurity, AI/ML, Software Engineering
GitHub: [sanaullahcode](https://github.com/sanaullahcode)
