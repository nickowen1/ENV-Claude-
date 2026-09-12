#!/usr/bin/env node
"use strict";

/**
 * Générateur de site vitrine à partir d'une fiche prospect JSON.
 * Usage : node generate.js <chemin-vers-prospect.json> [--template vitrine-classique]
 *
 * Voir README.md pour le schéma complet des champs acceptés.
 */

const fs = require("fs");
const path = require("path");

const DEFAULTS = {
  tagline: "",
  description: "",
  services: [],
  images: [],
  logo: "",
  primary_color: "#0b5fff",
  cta_text: "Nous contacter",
  phone: "",
  whatsapp: "",
  email: "",
  address: "",
  sector: "",
  agency_name: "",
};

function fail(message) {
  console.error("Erreur : " + message);
  process.exit(1);
}

function slugify(text) {
  return String(text)
    .normalize("NFD")
    .replace(/[̀-ͯ]/g, "")
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/(^-|-$)/g, "");
}

function escapeHtml(value) {
  return String(value)
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;");
}

function renderEach(template, data) {
  return template.replace(/{{#each (\w+)}}([\s\S]*?){{\/each}}/g, (match, key, inner) => {
    const arr = data[key];
    if (!Array.isArray(arr) || arr.length === 0) return "";
    return arr.map((item) => inner.replace(/{{\.}}/g, escapeHtml(item))).join("");
  });
}

function renderIf(template, data) {
  return template.replace(/{{#if (\w+)}}([\s\S]*?){{\/if}}/g, (match, key, inner) => {
    const value = data[key];
    const truthy = Array.isArray(value) ? value.length > 0 : Boolean(value);
    return truthy ? inner : "";
  });
}

function renderVars(template, data) {
  return template.replace(/{{(\w+)}}/g, (match, key) => {
    if (!(key in data)) return "";
    return escapeHtml(data[key]);
  });
}

function render(template, data) {
  return renderVars(renderIf(renderEach(template, data), data), data);
}

// Copie un asset fourni par le prospect (logo, image de galerie) vers le
// dossier de sortie et renvoie le chemin relatif à utiliser dans le HTML.
// Une URL distante (http/https) est utilisée telle quelle, sans copie.
function resolveAsset(sourcePath, baseDir, outAssetsDir, destBaseName) {
  if (!sourcePath) return "";
  if (/^https?:\/\//i.test(sourcePath)) return sourcePath;

  const resolved = path.isAbsolute(sourcePath) ? sourcePath : path.resolve(baseDir, sourcePath);
  if (!fs.existsSync(resolved)) {
    console.warn(`Attention : fichier introuvable, ignoré : ${sourcePath}`);
    return "";
  }
  const ext = path.extname(resolved);
  const destRelative = `assets/${destBaseName}${ext}`;
  fs.mkdirSync(outAssetsDir, { recursive: true });
  fs.copyFileSync(resolved, path.join(outAssetsDir, `${destBaseName}${ext}`));
  return destRelative;
}

function parseArgs(argv) {
  const args = { template: "vitrine-classique" };
  const positional = [];
  for (let i = 0; i < argv.length; i++) {
    if (argv[i] === "--template") {
      args.template = argv[++i];
    } else {
      positional.push(argv[i]);
    }
  }
  args.dataPath = positional[0];
  return args;
}

function main() {
  const args = parseArgs(process.argv.slice(2));
  if (!args.dataPath) {
    fail("usage : node generate.js <chemin-vers-prospect.json> [--template nom-du-template]");
  }

  const dataPath = path.resolve(args.dataPath);
  if (!fs.existsSync(dataPath)) fail(`fichier introuvable : ${dataPath}`);

  let prospect;
  try {
    prospect = JSON.parse(fs.readFileSync(dataPath, "utf8"));
  } catch (e) {
    fail(`JSON invalide dans ${dataPath} (${e.message})`);
  }

  if (!prospect.business_name) fail("le champ 'business_name' est obligatoire dans la fiche prospect");

  const slug = prospect.slug || slugify(prospect.business_name);
  const data = Object.assign({}, DEFAULTS, prospect, { slug });

  const templateDir = path.resolve(__dirname, "templates", args.template);
  if (!fs.existsSync(templateDir)) fail(`template introuvable : ${args.template} (${templateDir})`);

  const outDir = path.resolve(__dirname, "output", slug);
  const outAssetsDir = path.join(outDir, "assets");
  fs.mkdirSync(outDir, { recursive: true });

  const dataDir = path.dirname(dataPath);

  // Logo et galerie : copie des fichiers locaux fournis, URLs laissées telles quelles.
  data.logo = resolveAsset(prospect.logo, dataDir, outAssetsDir, "logo");
  if (Array.isArray(prospect.images)) {
    data.images = prospect.images
      .map((img, i) => resolveAsset(img, dataDir, outAssetsDir, `gallery-${i + 1}`))
      .filter(Boolean);
  }

  for (const file of ["index.html", "style.css", "script.js"]) {
    const srcFile = path.join(templateDir, file);
    if (!fs.existsSync(srcFile)) continue;
    const rendered = render(fs.readFileSync(srcFile, "utf8"), data);
    fs.writeFileSync(path.join(outDir, file), rendered, "utf8");
  }

  console.log(`Site généré : ${outDir}`);
}

main();
