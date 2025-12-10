# Microdown Hider

Ce projet lit un fichier Microdown contenant des exercices et génère automatiquement :

- une **version étudiante** (sans le code solution),
- une **version solutions** (avec le code solution).

Le chapitre est détecté à partir du nom du dossier : `Chapter12` → `Chap12`.

---

## Lancer le programme (Playground Pharo)

### Linux / macOS
```
MicHiderExtractor new
    sourceFile: (FileReference on: '/chemin/Chapter12/File1.md');
    process.
```

### Windows
```
MicHiderExtractor new
    sourceFile: (FileReference on: 'C:\chemin\Chapter12\File1.md');
    process.
```

---

## Résultat

Dans le même dossier :

- `File1.md` → version étudiante  
- `File1Solutions.md` → solutions
