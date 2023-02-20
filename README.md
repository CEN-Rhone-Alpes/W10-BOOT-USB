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

Avec ce XML on peut préparé un ordinateur jusqua l'ouverture de séssion pour se qui est du reste (Logiciel, Imprimente, WiFi, Etc...) c'est la que la commande ``<FirsLogonCommands intérvien>``

  
