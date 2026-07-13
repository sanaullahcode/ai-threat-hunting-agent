#!/usr/bin/env bash
# setup_repo.sh
# Initializes git and creates 10 clean, meaningful commits for this project.
#
# Usage:
#   chmod +x setup_repo.sh
#   ./setup_repo.sh
#   git remote add origin https://github.com/sanaullahcode/ai-threat-hunting-agent.git
#   git branch -M main
#   git push -u origin main

set -e

git init
git config user.name "Sana Ullah"
git config user.email "sanaullahcode@users.noreply.github.com"

git add LICENSE .gitignore
git commit -m "Initial commit: project scaffold and license"

git add README.md
git commit -m "Add project README with usage and architecture overview"

git add requirements.txt
git commit -m "Add project dependencies"

git add .env.example
git commit -m "Add environment variable template"

git add src/nvd_client.py
git commit -m "Implement NVD API v2.0 client for recent CVE retrieval"

git add src/cve_scorer.py
git commit -m "Implement CVE priority banding and exploitation heuristic"

git add src/threat_agent.py
git commit -m "Implement main CLI: threat hunt workflow and Claude report generation"

git add tests/test_cve_scorer.py
git commit -m "Add unit tests for CVE scoring logic"

git add reports/.gitkeep
git commit -m "Add reports output directory"

git add CONTRIBUTING.md
git commit -m "Add contributing guidelines"

echo ""
echo "Done. 10 commits created."
echo "Now run:"
echo "  git remote add origin https://github.com/sanaullahcode/ai-threat-hunting-agent.git"
echo "  git branch -M main"
echo "  git push -u origin main"
