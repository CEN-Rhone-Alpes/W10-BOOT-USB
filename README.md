# W10-BOOT-USB
Création d'une clé de BOOT (Bootstrap) Windows 10

## Les Objectif :

Création d'un PC sous Windows avec toutes les fonctionnalités nécessaires à son utilisation, de manière la plus automatique, en réduisant au maximum les manipulations de l'administrateur.

Pour permettre de réduire considérablement le temps accordé à ce type de tache, et le consacré à d'autres utilités.

## La Réalisation : 

### 1) Utilisation du logiciel Rufus
[![Licence](https://img.shields.io/badge/license-GPLv3-blue.svg?style=flat-square&label=License)](https://www.gnu.org/licenses/gpl-3.0.en.html)

Logiciel sous licence GPL v3 permettant de créer une clé USB de BOOT dans des versions de Windows allant de 7 à la 11 en toute simplicité.

 ![Rufus logo](https://raw.githubusercontent.com/pbatard/rufus/master/res/icons/rufus-128.png)
 
[__Official Website__](https://rufus.ie)

[__Github__](https://github.com/pbatard/rufus)

Au moment de l'utilisation de Rufus, il va débuter par le formatage du périphérique et par l'installation de tous les fichiers nécessaire à la réalisation d'une construction de l'image Windows.

![image](https://user-images.githubusercontent.com/120559974/220396662-3d3ffcd4-94fc-42ee-8645-c3169e48f062.png)
![image](https://user-images.githubusercontent.com/120559974/220397172-d73bb805-efb2-4903-aceb-274d6c6fb196.png)

Il va placer à l'intérieur du périphérique un fichier nommé ``unattend.xml``, c'est ce fichier qui sera lu au moment de l'installation et qui va donner de nombreuses directives.
 
### 2) Unattend.xml
On peut retrouver toutes les informations qui sont intégrables à l'intérieur de celui-ci sur le lien suivent :

[__Microsoft lear unattend__](https://learn.microsoft.com/fr-fr/windows-hardware/customize/desktop/unattend/microsoft-windows-shell-setup)

[__Microsoft automatiser installation__](https://learn.microsoft.com/fr-fr/windows-hardware/manufacture/desktop/automate-windows-setup?view=windows-11)

Ce XML fonctionne par un principe de Composants chacun va permettre de définir différentes stratégies de paramétrage sur des thématiques qui leur sont propres.

[__Liste des Composants__](https://learn.microsoft.com/fr-fr/windows-hardware/customize/desktop/unattend/components-b-unattend)

La Composants ``Microsoft-Windows-Shell-Setup``, c'est à l'intérieur de celui-ci que l'on va retrouver les éléments les plus importants qui sont liés au paramétrage de Windows et du profil :
- Out-Of-Box Experience : ``<OOBE>``
- La création de profil : ``<UserAccount>``
  - Création de profil utilisateur : ``<LocalAccount>``
  - Modification de profil administrateur : ``<AdministratoPassword>``
- Connexion automatique à la première utilisation : ``<AutoLogon>``
- Les commande a réalisé l'or de la première connexion : ``<FirsLogonCommands>``
- L'intégration de la clé d'activation Windows : ``<ProductKey><Key>`` ou ``<ProductKey>``
  
On retrouve également des paramétrages non-indispensable, mais pratique pour modifier des paramétrages telle que :
- La page de support : ``<OEMInformation>``
- Modification du paramétrage d'affichage : ``<Display>``
- Spécifie les informations d'installation : ``<Diagnostics>``
- Application dans la bar de raccourci : ``<TaskbarLinks>``
- Application sur l'écran d'accueil : ``<StartTiles>``
- Éléments du style visuel : ``<Themes>``

L'on retrouve deux autre composant qui est utiles pour la préparation de postes, ils sont plus liés au fonctionnement même de l'ordinateur et à l'image d'installation :
- ``Microsoft-Windows-Setup`` : Sélectionner l’image Windows et configurer le système d’exploitation Windows PE
  - Gestion des partitions : ``<DickConfiguration>``
  - Spécifie les données utilisateur : ``<UserData>``
- ``Microsoft-Windows-International-Core`` : Paramétrage des langues utilisé par le système

Avec ce XML, on peut préparer un ordinateur jusqu'à l'ouverture de session, pour ce qui est du reste (logiciel, Imprimante, Wifi, etc...) c'est là que la commande ``<FirsLogonCommands>`` intervient, elle est utilisée pour exécuté un script BATCH(``.bat``).

### 3) Les script .bat & .ps1
Sur le périphérique, le dossier où est stocké le ``unattende.xml`` qui est "``USB:\sources\$OEM$\$$\Panther``" est le futur dossier que l'on retrouvera sur le nouveau post au chemin suivent "``C:\Windows\Panther``" ce qui nous permet de créer et de placé à l'intérieur de celui-ci tout ce qui nous est nécessaire de trouver localement pour la préparation de la session.

Le fichier ``.bat`` dans ``"Panther"`` va permettre l'exécution d'autre fichier en t'en qu'administrateur au moment de la première ouverture de session.

Dans les fichiers ``.ps1``(PowerShell) l'on peut réaliser énormément d'action telle que :

- Copié, coupé, coller
- Création et suppression de dossier
- Création de raccourci
- Installation de logiciel
- Installation de Wifi via .xml
- Génération d'un .xml du Wifi connecté
- Modification de la base de registre
- Désinstallation de logiciel
- Modification des paramètres de la bar des taches et du menu de démarrage
- Génération d'un .xml de la bar des taches
- Modification du paramétrage de restauration
- Modification de la gestion de la batterie, mise en veille et alimentation a la fermeture du capot
- installation de module PowerShell
- Installation et suppression d'imprimante
- Ouverture de Page Web
- Utilisation de msiexc
- Rendre permanent les raccourcis serveur
- Création de boucle
- Détection de logiciel en cours d'exécution
- Lecteur de fichier .xml
- Redémarre et arrêt du PC
- Fermeture de session
- Modification du mot de passe
- Activation ou désactivation de compte utilisateur
- Renommage PC
- Capture d'écran
- Copié dans le presse dans le papier
- Envoie par mail
- Trouve la clé d'activation Windows

Mais pour que cela fonctionne, il faut avoir préparé différents éléments qui sont nécessaires au paramétrage interne de certaines fonctionnalités Windows ou logiciel :

- Les .reg nécessaire à la modification d'interface ou de paramétrage :
  - Paramétrage d'interface explorateur
  - Paramétrage de la bar des taches (actualité, météo, navigateur de fenêtre, Cortana, etc...)
  - Paramétrage du fond d'écran et résolution
  - Interface et option pour QGIS 2.xx
  - Lien WMS/WFS/PostGIS pour QGIS 2.xx
  - Activation de plugin pour QGIS 2.xx
- Le .msp pour la suite Microsoft Office
- Le .tvopt pour TeamViewer
- Le .xml pour les raccourcis de bar des taches et le menu de démarrage
- Les .xml pour chaque point d'accès Wifi
- Les fichiers de paramétrage de GroupePolicy
- Lien de la page pour définir le navigateur par défaut
- Installateur QGIS 3.xx
- Edité les fichier de gpedit.msc puis en faire une copie ([__Customize Windows 10 start screens__](https://learn.microsoft.com/en-us/windows/configuration/customize-windows-10-start-screens-by-using-group-policy)) 

Une fois tout préparé, l'on peut lancer le BOOT d'un PC presque sans intervention.

<i> *Combiné à l'utilisation de WAPT pour l'installation de la plupart de nos logiciels* </i>

#### WAPT
[![Licence](https://img.shields.io/badge/License-Licence%20propri%C3%A9taire-red?style=flat-square&label=License)](https://www.gnu.org/philosophy/categories.html#ProprietarySoftware)

<img src=https://user-images.githubusercontent.com/120559974/220587385-b290301e-8da7-4616-bf8a-185ef3fe3dc7.png width="40%" height="40%">

[__Official Website__](https://www.tranquil.it/gerer-parc-informatique/decouvrir-wapt/)

WAPT est un logiciel qui permet de réaliser la création de paquets affins, d'effectuer des installation et mise à jour de logiciel de marnière simple, silencieuse et automatique sur l'intégralité d'un parc informatique sans besoin d'intervention physique, pour se faire le logiciel fonctionne de la marnière suivante :

![fonctionnement_wapt](https://user-images.githubusercontent.com/120559974/220595018-62692b72-8433-4e61-b837-4a330638974e.png)


WAPT Self Service est une interface graphique qui permet de simplement et de marnière intuitive effectuée :
 - installation, mise à jour et désinstallation
 - Création de paquet
 - Recherche et filtrage des postes

<i> Interface de gestion des postes </i>

<img src=https://user-images.githubusercontent.com/120559974/220622165-4867864c-9d3b-4ca8-aecf-9586e93761b5.png width="40%" height="40%">

La mise à disposition d'un store de logiciels dans WAPT Self Service permet de facilité la création de paquet avec une bibliothèque de logiciel qui est mise à disposition.

<i>Bibliothèque de logiciel</i>

<img src=https://user-images.githubusercontent.com/120559974/220603306-c29d9fa8-497f-4e1a-8625-651aee0c12e8.png alt="Bibliothèque de logiciel" width="40%" height="40%">
 
<i> Interface des paquets </i>

<img src=https://user-images.githubusercontent.com/120559974/220622169-6e3f4f23-cdad-44cb-85cf-a482e0b3d3cf.png width="40%" height="40%">

<i> Interface des paquets du poste </i> 

<img src=https://user-images.githubusercontent.com/120559974/220622173-537f152d-96f3-43d4-af3e-e1f6b89e2d18.png width="40%" height="40%">

### 4) Générateur unattend.xml
Pour simplifier les différentes manipulations de unattend.xml l'on peut créer sous différents formats un GUI, mon générateur de .xml est au format PowerShell.

![image](https://user-images.githubusercontent.com/120559974/220123026-aa2b7ddb-e11b-4172-b84e-c16752ad7bbc.png)

[__Mon Unattend GUI__](https://github.com/tlaveille-CENRA/W10-BOOT-USB/tree/main/Panther/InstalCustome/Unattend)

## L'utilisation :

 1) Crée le fichier unattend.xml
 2) Placez la clé dans le PC à BOOT
 3) Ouvrir le menu de BOOT du BIOS et lancé avec le périphérique
 4) Acceptez les conditions d'utilisation de Windows
 5) Choix du formatage avancé
 6) Supprimez toutes les anciennes partitions
 7) BOOT sur une partition libre
 8) Attendre la fin de l'installation complète du PC

## Les axes futurs

Testé l'utilisation de ``imgmgr.exe``("Windows System Image Manager"), un outil du "Assessment and Deployment Kit" peut potentiellement permettre de faciliter 
la création d'un XML et de testé la validité de celui-ci.

[__Windows System Image Manager__](https://learn.microsoft.com/fr-fr/windows-hardware/customize/desktop/wsim/windows-system-image-manager-technical-reference)

Exploré les changements de Windows 10 à Windows 11, du unattend et des scripts PowerShell.

*Attention, fin en 2025 des mises à jour de sécurité pour Windows 10*

# Fin
