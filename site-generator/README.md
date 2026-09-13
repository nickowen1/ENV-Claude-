# Site Generator

Génère un site vitrine statique (HTML/CSS/JS, sans dépendance) à partir d'une fiche prospect JSON — pour envoyer rapidement une première version de site à un prospect (marché test : Bénin).

Ce générateur ne fait que **produire les fichiers**. Pas de recherche de prospects (déjà géré par ailleurs), pas de déploiement automatique pour l'instant — le dossier de sortie est prêt à être zippé/envoyé ou déposé sur n'importe quel hébergement statique.

## Utilisation

```bash
node generate.js data/example-prospect.json
# -> output/cotonou-electro-services/{index.html, style.css, script.js, assets/}
```

Avec un template précis :

```bash
node generate.js data/ma-fiche.json --template vitrine-corporate
```

## Templates disponibles

| Template | Style | Bon pour |
|---|---|---|
| `vitrine-classique` (défaut) | Bleu, dégradé, moderne généraliste | Formation, services B2B de terrain (nettoyage, sécurité), tout secteur en premier envoi type |
| `vitrine-corporate` | Navy/bleu, flat design, sans ombres, angles nets | Cabinets comptables/fiscaux/juridiques/RH, conseil |
| `vitrine-premium` | Sombre, doré, Playfair Display, boutons arrondis | Architecture, ingénierie, bureaux d'études (met en valeur des réalisations en galerie) |
| `vitrine-sante` | Bleu-vert calme, Nunito/Inter, bouton "Appeler" toujours visible | Cliniques, cabinets médicaux, opticiens — CTA RDV/WhatsApp mis en avant dès le hero |

`vitrine-corporate` et `vitrine-premium` réutilisent des palettes de couleurs et associations typographiques réelles de la base de données locale du skill [ui-ux-pro-max](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) (nextlevelbuilder, licence MIT — palettes "B2B Service" et "E-commerce Luxury", typographies "Modern Professional" et "Classic Elegant"), pas des choix arbitraires. `vitrine-sante` suit les conventions UI usuelles du secteur santé (bleu-vert rassurant, vert pour les actions de contact) plutôt qu'une palette de cette base de données.

Ce mapping niche → template a été construit à partir d'un rapport de prospection réel (26 prospects qualifiés, secteurs Bénin), pas au hasard — voir la répartition des sous-secteurs pour ajuster si de nouvelles niches apparaissent.

Ouvre ensuite `output/<slug>/index.html` directement dans un navigateur pour vérifier avant envoi.

## Schéma d'une fiche prospect (JSON)

| Champ | Obligatoire | Description |
|---|---|---|
| `business_name` | **oui** | Nom de l'entreprise, utilisé aussi pour générer le `slug` si absent. |
| `slug` | non | Nom de dossier de sortie (ex. `mon-entreprise`) ; déduit de `business_name` sinon. |
| `tagline` | non | Phrase d'accroche sous le nom, dans le hero. |
| `description` | non | Paragraphe "À propos". Section masquée si absent. |
| `services` | non | Liste de chaînes — une carte par service. Section masquée si vide. |
| `images` | non | Liste de chemins (locaux, relatifs au fichier JSON) ou d'URLs — galerie photo. Section masquée si vide. |
| `logo` | non | Chemin local ou URL. Masqué dans l'en-tête si absent. |
| `primary_color` | non | Couleur d'accent (hex), défaut `#0b5fff`. |
| `cta_text` | non | Texte du bouton d'appel à l'action, défaut "Nous contacter". |
| `phone` | non | Affiché avec lien `tel:`. |
| `whatsapp` | non | Numéro complet sans `+` ni espaces (ex. `22997000000`) — lien `wa.me`. |
| `email` | non | Lien `mailto:`. |
| `address` | non | Affichée telle quelle. |
| `sector` | non | Informatif seulement pour l'instant (secteur d'activité). |
| `agency_name` | non | Si renseigné, affiche "Site conçu par [agency_name]" en pied de page. |
| `team` | non | Liste d'objets `{ "name": "...", "role": "..." }` — section "Notre équipe". Masquée si vide. |
| `hours` | non | Texte libre (ex. `"Lun-Ven 8h-18h, Sam 9h-13h"`), affiché dans la section Contact. |
| `testimonials` | non | Liste d'objets `{ "quote": "...", "author": "..." }` — section témoignages/avis. Masquée si vide. |

Les fichiers `logo`/`images` locaux référencés dans le JSON sont recherchés **relativement à l'emplacement du fichier JSON lui-même**, puis copiés dans `output/<slug>/assets/`. Une URL (`http://` ou `https://`) est utilisée telle quelle, sans copie.

## Ajouter un nouveau template

Crée un dossier sous `templates/<nom>/` avec `index.html`, `style.css`, `script.js`. Syntaxe de gabarit disponible dans ces trois fichiers :

- `{{champ}}` — insère la valeur du champ (échappée pour le HTML).
- `{{#if champ}}...{{/if}}` — n'affiche le bloc que si le champ est renseigné (ou si la liste n'est pas vide).
- `{{#each champ}}...{{.}}...{{/each}}` — répète le bloc pour chaque élément d'une liste de chaînes, `{{.}}` référence l'élément courant.
- `{{#each champ}}...{{.propriete}}...{{/each}}` — pareil pour une liste d'objets (ex. `team`, `testimonials`), `{{.name}}`/`{{.role}}`/`{{.quote}}`/`{{.author}}` référencent les propriétés de l'élément courant.

## Prochaine étape (hors périmètre de ce premier tour)

Pour les prospects prêts à payer plus, le passage à une version plus complète (formulaires dynamiques, back-office, etc.) se ferait sur un environnement type NestJS — volontairement hors périmètre ici, ce générateur reste dédié à la version statique "aperçu rapide".
