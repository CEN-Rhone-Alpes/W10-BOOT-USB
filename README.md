# W10-BOOT-USB
Création d'une clé de boot Windows 10

## Les Objectif :

Création d'un PC sous Windows avec tout les fonctionnalité nécessaire à sont utilisation, de magnier la plus automatique en réduisant au maximume les manipulation de l'administrateur.

## La Réalisation : 
 
### 1) Utilisation du logiciel Rufuse
Logiciel sous license GPLv3 permetan de crée une clé usb de boot dans des version de windows allant de 7 à 11
 
https://github.com/pbatard/rufus
 
Au moment de l'utilisation de Rufuse, il va débuté par le formatage du périférique et par l'instalation de tout les fichier nécessaire a la réalisation d'une instalation windows.

il va placé a l'intérieur du périférique un fichier nomé "unattend.xml" c'est ce fichier qui sera lu par au moment de m'installation.
 
### 2) Unattend.xml
On peut retrouvé tout les information qui sont intégrable à l'intérieur de celui si sur le lien suivent :

https://learn.microsoft.com/fr-fr/windows-hardware/customize/desktop/unattend/components-b-unattend

ce XML contien un composants nomé "Microsoft-Windows-Shell-Setup" ces a l'intérieur de celui si que l'on va retrouvé les élement les plus important :
  - Out-Of-Box Experience : ``<OOBE>``
  - La création de profile : ``<UserAccount>``
    - Création de profile utilisateur : ``<LocalAccount>``
    - Modification de profil administrateur : ``<AdministratoPassword>``
  - Connection automatique au premier utilisation : ``<AutoLogon>``
  - Les commande a réalisé l'or de la premier connection : ``<FirsLogonCommands>
  - L'intégration de la clé d'activation windows : ``<ProductKey><Key>`` or ``<ProductKey>``

On retrouve égalment le composants "Microsoft-Windows-International-Core" ce qui permet de définir une langue.

Avec ce XML on peut préparé un ordinateur jusqua l'ouverture de séssion pour se qui est du reste (Logiciel, Imprimente, WiFi, Etc...) c'est la que la commande ``<FirsLogonCommands intérvien>`` est utilisé pour éxécuté un scrip BATCH(``.bat``).

### 3) Les script .bat & .ps1
Sur le périférique le dossier ou est stocker ``le unattende.xml`` qui est "``USB:\sources\$OEM$\$$\Panther``" est le future dossier que l'on retrouvera sur le nouveau post au chemin suivent "``C:\Windows\Panther``" ce qui nous permet de crée et de placé a l'intérieur de selui ci tout ce qui nous est néssésair de trouvé localment pour la préparation de la séssion.

Le fichier .bat dans "Panther" va pérmetre l'exécution d'autre fichier en t'en que administrateur au moment de la premier ouverture de séssion.

dans les fichier .ps1 l'on peut réalisé énormément d'acteur telle que:
 - Copier, Coupé, Coller
 - Création et supprésiont de dossier
 - Création de racoursi
 - Installation de logiciel
 - Installation de WiFi
 - Modification de la base de registre
 - Désinstalation de logiciel
 - Modification des parametre de la bar des tache et du menu de démarage
 - Modification du parramétrage de réstauration
 - Modification de la gestion de la battrie,mise en veille et alimentation a la fermeture du capot
 - installation de module PowerShell
 - Instammation/Supprésion d'imprimente
 - Ouverture de Page Web
 - Utilisation de msiexc
 - Rendre permanant les raccourci serveur
 - Création de boucle
 - Détection de logiciel en cours d'éxcution
 - Lecteur de fichier .xml
 - Redémarge et arret du PC
 - Fermeture de séssion
 - Modification du mot de passe
 - Activation ou désactivation de compte utilisateur
 - Renomage PC
 - Capture d'écrant
 - Copie dans le presse dans le papier
 - Envoie de mail

Mais pour que cella fonctione il faut avoir préparé différent élement nécessaire au paramétrage interne à sertain fonctionement windows ou logiciel :

 - Les .reg nécessaire à la modification de interface :
   - Interface explorateur
   - Paramétrage de la bar des tache (actualité, météo, navigateur de fênetre, cortana, etc...)
   - Paramétrage du font d'ecrant et réssolution
   - Interface & option pour QGIS 2.xx
   - Lien WMS/WFS/Postgisql pour QGIS 2.xx
   - Activation de Plugin pour QGIS 2.xx
 - Le .msp pour la suite Microsoft Office
 - Le .tvopt pour TeamViewer
 - Le .xml pour les racourrsi de bar des tache et le menu de démarage
 - Les .xml pour chaque point d'accet WiFi
 - Les fichier de paramétrage de GroupePolicy
 - Lien de la page pour déffinisent le navigateur par defaut
 - Installateur QGIS 3.xx

Une fois tout c'est élément préparé l'on peut lancé le boot d'un PC presque sans intervention.

### 4) Générateur unattend.xml
Pour simplifier les différente manipulation du unattend.xml l'on peut crée sous différent format un GUI, mon générateur de .xml est au format PowerShell.


  
