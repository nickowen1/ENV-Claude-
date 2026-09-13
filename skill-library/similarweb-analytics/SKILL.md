---
name: similarweb-analytics
description: "Analyze websites and domains using SimilarWeb traffic data. Get traffic metrics, engagement stats, global rankings, traffic sources, and geographic distribution for comprehensive website research."
---

# SimilarWeb Analytics

Comprehensive website and domain analysis using SimilarWeb traffic data.

> **Corrigé le 2026-09-13** : la version d'origine importait `ApiClient` depuis `/opt/.manus/.sandbox-runtime`, un chemin propre à la plateforme Manus, absent de Claude Code — tout appel échouait. Remplacé ci-dessous par un client HTTP standard (`requests`) authentifié par une vraie clé API SimilarWeb, fonctionnel dans n'importe quel environnement Python. Voir `AUDIT.md` pour le détail du correctif.

## Core Capabilities

- **Traffic Analysis**: Total visits, unique visitors, traffic trends
- **Engagement Metrics**: Bounce rate, pages per visit, average visit duration
- **Global Ranking**: Website ranking over time
- **Traffic Sources**: Marketing channels (desktop and mobile)
- **Geographic Distribution**: Traffic breakdown by country

## Prérequis

- Un compte SimilarWeb avec accès API (payant — SimilarWeb ne propose pas d'accès API gratuit), et une clé API valide.
- La clé doit être fournie via la variable d'environnement `SIMILARWEB_API_KEY`, **jamais en clair dans le code ou dans une conversation**.
- `pip install requests` si non déjà disponible.

**Important — chemins d'endpoints dépendants du plan** : SimilarWeb documente ses endpoints par version d'API (v1 legacy encore actif pour certains, v5 consolidé pour d'autres) et certains endpoints ne sont disponibles que sur les plans Standard/Enterprise. Le chemin `global-rank` ci-dessous est stable et largement documenté ; pour les autres, vérifie le chemin exact dans ta documentation de compte (docs.similarweb.com/api-v5, section correspondant à ton abonnement) avant un usage en production — ne suppose pas que les chemins ci-dessous sont figés dans le temps.

## API Usage

Client réutilisable, à placer une fois en tête de script :

```python
import os
import requests

class SimilarWebClient:
    BASE_URL = "https://api.similarweb.com"

    def __init__(self):
        self.api_key = os.environ.get("SIMILARWEB_API_KEY")
        if not self.api_key:
            raise RuntimeError(
                "SIMILARWEB_API_KEY n'est pas définie. "
                "Exporte ta clé API SimilarWeb dans cette variable d'environnement avant d'utiliser ce skill."
            )

    def get(self, path, params=None):
        params = dict(params or {})
        params["api_key"] = self.api_key
        response = requests.get(f"{self.BASE_URL}{path}", params=params, timeout=30)
        response.raise_for_status()
        return response.json()

client = SimilarWebClient()
```

Common parameters:
- `domain`: Website domain (e.g., "google.com")
- `start_date`: Start date (YYYY-MM). Max 12 months ago
- `end_date`: End date (YYYY-MM). Max 12 months ago, default is 1 month ago (most recent complete month)
- `main_domain_only`: Exclude subdomains if True (default: False)

**Default time ranges vary by API:**
- Global Rank, Visits Total, Unique Visit, Bounce Rate: default **6 months**
- Traffic Sources (Desktop/Mobile), Traffic by Country: default **3 months**

### Get Global Rank

Endpoint stable et vérifié (docs.similarweb.com) :

```python
result = client.get(f"/v1/website/amazon.com/global-rank/global-rank")
```

### Get Website Visits Total

```python
result = client.get(
    "/v5/website-analysis/websites/traffic-and-engagement",
    params={
        "domain": "amazon.com",
        "country": "world",
        "granularity": "monthly",
        "start_date": "2025-07",
        "end_date": "2025-12",
        "metrics": "visits",
    },
)
```

### Get Unique Visit

```python
result = client.get(
    "/v5/website-analysis/websites/traffic-and-engagement",
    params={
        "domain": "amazon.com",
        "start_date": "2025-07",
        "end_date": "2025-12",
        "metrics": "unique_visitors",
    },
)
```

### Get Bounce Rate

```python
result = client.get(
    "/v5/website-analysis/websites/traffic-and-engagement",
    params={
        "domain": "amazon.com",
        "country": "world",
        "granularity": "monthly",
        "start_date": "2025-07",
        "end_date": "2025-12",
        "metrics": "bounce_rate",
    },
)
```

### Get Traffic Sources - Desktop

Returns breakdown by channel: Organic Search, Paid Search, Direct, Display Ads, Email, Referrals, Social Media.

```python
result = client.get(
    "/v5/website-analysis/websites/traffic-sources/overview-desktop",
    params={
        "domain": "amazon.com",
        "country": "world",
        "granularity": "monthly",
        "start_date": "2025-07",
        "end_date": "2025-12",
    },
)
```

### Get Traffic Sources - Mobile

```python
result = client.get(
    "/v5/website-analysis/websites/traffic-sources/overview-mobile-web",
    params={
        "domain": "amazon.com",
        "country": "world",
        "granularity": "monthly",
        "start_date": "2025-07",
        "end_date": "2025-12",
    },
)
```

### Get Total Traffic by Country

Returns traffic share, visits, pages per visit, average time, bounce rate and rank by country.

- `limit`: Number of countries to return (default: 1, max: 10)
- **Date range limit**: max 3 months (unlike other APIs)

```python
result = client.get(
    "/v5/website-analysis/websites/geography/traffic-by-country",
    params={
        "domain": "amazon.com",
        "start_date": "2025-10",
        "end_date": "2025-12",
        "limit": "10",
    },
)
```

## When to Use

Invoke APIs when users mention:
- Domain names: "google.com", "amazon.com"
- Traffic queries: "traffic", "visits", "visitors"
- Ranking queries: "rank", "ranking", "how popular"
- Engagement queries: "bounce rate", "engagement"
- Source queries: "traffic sources", "marketing channels"
- Geographic queries: "countries", "geographic"
- Comparison queries: "compare", "vs"

## Data Limitations

- Historical data: max 12 months
- Geography: worldwide only
- Granularity: monthly only
- Latest data: last complete month

## Important: Save Data to Files

API calls may fail mid-execution due to credit depletion. **Always save all retrieved data to files immediately** to avoid data loss and prevent redundant API calls.

## Gestion des erreurs

`response.raise_for_status()` lève une exception HTTP explicite (401 = clé invalide, 403 = endpoint non inclus dans le plan d'abonnement, 429 = quota de crédits dépassé) plutôt que d'échouer silencieusement — traite ces cas explicitement dans le code appelant plutôt que de supposer que chaque appel réussit.
