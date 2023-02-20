# W10-BOOT-USB
Création d'une clé de boot Windows 10

## Les Objectif :

Création d'un PC sous Windows avec toutes les fonctionnalités nécessaire à son utilisation, de manière la plus automatique en réduisant au maximum les manipulations de l'administrateur.

## La Réalisation : 

### 1) Utilisation du logiciel Rufus
[![Licence](https://img.shields.io/badge/license-GPLv3-blue.svg?style=flat-square&label=License)](https://www.gnu.org/licenses/gpl-3.0.en.html)

Logiciel sous licence GPLv3 permettant de crée une clé USB de boot dans des versions de Windows allant de 7 à la 11 en tout simplicités.

 ![Rufus logo](https://raw.githubusercontent.com/pbatard/rufus/master/res/icons/rufus-128.png)
[__Official Website__](https://rufus.ie)

https://github.com/pbatard/rufus

Au moment de l'utilisation de Rufus, il va débuter par le formatage du périphérique et par l'installation de tous les fichiers nécessaire à la réalisation d'une construction de l'image Windows.

Il va placer à l'intérieur du périphérique un fichier nommé "unattend.xml ", c'est ce fichier qui sera lu au moment de l'installation et qui va donner de nombreuses directives.
 
### 2) Unattend.xml
On peut retrouver toutes les informations qui sont intégrables à l'intérieur de celui-ci sur le lien suivent :

https://learn.microsoft.com/fr-fr/windows-hardware/customize/desktop/unattend/components-b-unattend

Ce XML contient un composant nommé "Microsoft-Windows-Shell-Setup ", c'est à l'intérieur de celui-ci que l'on va retrouver les éléments les plus importants :
  - Out-Of-Box Experience : ``<OOBE>``
  - La création de profil : ``<UserAccount>``
    - Création de profil utilisateur : ``<LocalAccount>``
    - Modification de profil administrateur : ``<AdministratoPassword>``
  - Connexion automatique à la première utilisation : ``<AutoLogon>``
  - Les commande a réalisé l'or de la premier connection : ``<FirsLogonCommands>
  - L'intégration de la clé d'activation windows : ``<ProductKey><Key>`` or ``<ProductKey>``

On retrouve également le composant "Microsoft-Windows-International-Core" ce qui permet de définir une langue.

Avec ce XML, on peut préparer un ordinateur jusqu'à l'ouverture de session pour ce qui est du reste (logiciel, Imprimante, Wifi, etc...) c'est là que la commande ``<FirsLogonCommands intérvien>`` est utilisé pour éxécuté un scrip BATCH(``.bat``).

### 3) Les script .bat & .ps1
Sur le périphérique le dossier ou est stocké le ``unattende.xml`` qui est "``USB:\sources\$OEM$\$$\Panther``" est le futur dossier que l'on retrouvera sur le nouveau post au chemin suivent "``C:\Windows\Panther``" ce qui nous permet de crée et de placé à l'intérieur de celui-ci tout ce qui nous est néssésair de trouvé localement pour la préparation de la session.

Le fichier .bat dans "Panther" va permettre l'exécution d'autre fichier en t'en qu'administrateur au moment de la première ouverture de session.

Dans les fichiers .ps1(PowerShell) l'on peut réaliser énormément d'action telle que:

- Copié, coupé, coller
- Création et suppression de dossier
- Création de raccourci
- Installation de logiciel
- Installation de Wifi
- Modification de la base de registre
- Désinstallation de logiciel
- Modification des paramètres de la bar des taches et du menu de démarrage
- Modification du paramétrage de restauration
- Modification de la gestion de la batterie, mise en veille et alimentation a la fermeture du capot
- installation de module PowerShell
- Installation et suppression d'imprimante
- Ouverture de Page Web
- Utilisation de msiexc
- Rendre permanant les raccourcis serveur
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

- Les .reg nécessaire à la modification d'interface ou de parmamétrage:
  - Paramétrage de lnterface explorateur
  - Paramétrage de la bar des taches (actualité, météo, navigateur de fenêtre, cortana, etc...)
  - Paramétrage du fond d'écran et résolution
  - Interface & option pour QGIS 2.xx
  - Lien WMS/WFS/PostgiSQL pour QGIS 2.xx
  - Activation de plugin pour QGIS 2.xx
- Le .msp pour la suite Microsoft Office
- Le .tvopt pour TeamViewer
- Le .xml pour les raccourcies de bar des tache et le menu de démarrage
- Les .xml pour chaque point d'accès Wifi
- Les fichiers de paramétrage de GroupePolicy
- Lien de la page pour définir le navigateur par défaut
- Installateur QGIS 3.xx

Une fois tout préparé, l'on peut lancer le boot d'un PC presque sans intervention.

### 4) Générateur unattend.xml
Pour simplifier les différentes manipulations du unattend.xml l'on peut créer sous différents formats un GUI, mon générateur de .xml est au format PowerShell.


  
