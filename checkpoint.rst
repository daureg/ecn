
.. vim: tw=80 spell:

Compte rendu à mi-parcours [#]_
===============================

.. [#] un peu plus que la moitié même…

Prise en main
~~~~~~~~~~~~~

Puisque le projet avait débuté dès 2010, la première semaine a en partie été
consacré à se familiariser avec le travail réalisé par Elsa. Partant du
volumineux nuage de points capté par MCG3D, elle l'avait découpé en différentes
tranches pour qu'il soit plus facilement manipulable.  Elle les avait ensuite
convertis en modèles polygonaux à l'aide du logiciel Polyworks puis avait
interpolé la couleur de chaque point sur les faces auxquelles ils appartenaient.
Enfin avait eu lieu une étape de simplification.  Malheureusement, ce processus
avait rendu les couleurs floues et introduit du bruit. Après avoir obtenu ce
modèle, elle l'avait exploité avec un système logiciel  Celui-ci souffrait
néanmoins de deux problèmes. D'abord, alors qu'il fonctionnait à son départ, ce
n'était plus le cas à notre arrivée. En outre, ce dysfonctionnement était
difficilement à diagnostiquer car malgré l'important effort de documentation
réalisé, le système était un assemblage hétérogène de plusieurs logiciels et
langages. Il s'appuyait sur une plateforme linux qui exécutait, outre un serveur
audio et un serveur DHCP, un ensemble de composants développés par la SAT :
`SPIN <http://spinframework.org/content/overview>`_. Cette bibliothèque libre
(écrite en C++) encapsule l'utilisation d'OpensceneGraph pour la visualisation
3D, OpenSoundControl pour la communication réseau et la téléprésence, ainsi que
python pour le scripting et les interactions. Le tout était piloté par une
interface en pure data à l'aide de `pdsheefa
<http://code.sat.qc.ca/redmine/projects/pdsheefa/wiki/About>`_. Autant dire que
les messages d'erreur étaient pour le moins perdus dans ces diverses couches et
donc assez ardus à exploiter. Pour assombrir encore le tableau, tous ces
logiciels étaient restés dans leur version de l'été 2011 et mes essais de mis à
jour n'ont fait que rajouter des incompatibilités.

Même si ces écueils auraient sans doute pu être surmontés à force de
persévérance, les efforts à fournir semblaient disproportionnés en comparaison
des résultats attendus. En effet, au-delà des soucis technique, le modèle de la
chapelle utilisé jusque-là ne donnait pas une entière satisfaction. Suivant les
recommandations de notre maitre de stage et de M. Vesac, nous avons donc décidé
de repartir sur de nouvelles bases (en espérant que d'éventuels futurs
stagiaires n'aient pas à emprunter une troisième voie l'année prochaine…). En
l'occurrence, il s'agissait de reconstruire le modèle à partir du scan initial
et de se baser sur Unity pour la visualisation et l'interaction.

Unity
~~~~~

`Unity <http://unity3d.com/unity/>`_ est à la fois un moteur de rendu temps
réel, un intégrateur de contenus multimédias et un éditeur/compilateur de code.
`D'après <http://fr.wikipedia.org/wiki/Unity_(moteur_de_jeu)>`_ wikipédia, on
peut le comparer à Virtools, à l'UDK ou au CryEngine. S'il est majoritairement
utilisé pour réaliser des jeux vidéos, il est aussi utilisé dans le domaine de
l'architecture ou de l'éducation. Basé sur de nombreuses technologies libres
(OpenGL, Mono [#]_, OggVorbis, Boo, theora, zlib, png, curl, scite, freetype,
…), il est néanmoins propriétaire et peut donc aussi intégrer le moteur PhysX de
Nvidia pour la simulation physique. Il existe une version gratuite qui ne permet
pas d'accéder à l'ensemble des fonctionnalités de la version professionnelle,
facturée 1150€ — et qui s'est avérée nécessaire pour réaliser la projection dans
le panoscope, voir plus loin. Il est possible d'exporter ses résultats sous
forme de binaires pour Windows, MacOS (et Linux dans la future version 4) ainsi
qu'en flash et dans un format destiné à un plugin web spécifique. Moyennant une
nouvelle contribution à la cause, on peut aussi exporter vers iOS et Android.

.. [#] c'est bizarre à dire, mais c'est libre aussi…

Concrètement, après avoir lancé l'éditeur, on peut importer des *assets* [#]_
qui peuvent être des textures, des sons, des vidéos, des scripts ou encore des
modèles 3D dans divers formats, chaque importation étant paramétrée par
différents paramètres, notamment le degré de compression du son ou des images.
Tous ces assets sont regroupés dans une banque de donnée [#]_ et on peut ensuite
créer une *scène* puis la peupler avec des assets. Ils accèdent alors au statut
convoité de *GameObject* [#]_, à qui on peut affecter des *Composants* [#]_ pour
préciser leur comportement. Ainsi, tous les objets possèdent un composant
*transform* qui stocke leur position, la rotation et leur échelle et que l'on
peut modifier en temps réel. La plupart ont aussi un composant *renderer* (qui
définit les paramètres de représentation comme les matériaux utilisés ou les
ombres projetées) et un *collider* (qui spécifie la forme et les dimensions de
la bounding box). Certains objets spécifiques disposent de composants
particuliers. Au hasard, le composant *Camera* d'une caméra, qui permet de fixer
les options de projection, de culling, etc, le *Character Controller* qui gère
la physique irréaliste d'un personnage de jeu vidéo qui peut faire des
demi-tours instantanés quel que soit sa masse et sa vitesse ou le *rigidbody*,
plus conforme à la science (ou du moins à sa version simulée). La `liste
complète <http://unity3d.com/support/documentation/Components/index.html>`_ est
volumineuse et comprend aussi ce qui se rapporte à l'audio, aux particules, à
l'interface utilisateur, etc.

.. [#] qu'on pourrait traduire par *ressource* mais ce serait plus vague (et
        plus long à taper…).
.. [#] c'est là une des particularités d'Unity puisque les assets sont stockés
        un dossier spécial sur le disque dur et sont automatiquement versionnés.
        En cas de crash de l'interface et même sans sauvegarde, tous les assets
        sont encore présents au redémarrage, sauf le dernier, qui est soupçonné
        d'être le responsable de l'incident.
.. [#] on ne peut désormais plus douter de l'orientation initiale de Unity…
.. [#] *Components* dans la version originale, mais on est tout de même au
        Québec, un peu de respect pour la langue de Molière !

Au-delà de tous ces composants réutilisables qui couvrent déjà un large panel de
besoins, Unity permet de spécifier des comportements personnalisés au moyen de
scripts. Plus précisément, chaque script implémente une sous classe de la classe
``MonoBehaviour`` et devient un composant qu'on peut alors ajouter à n'importe
quel GameObject. Il est paramétrable par ses variables membres publiques qui
sont visibles dans l'interface principale. Ces scripts peuvent être écrits en
Javascript [#]_, C# [#]_ ou Boo [#]_. Ils sont compilés une première fois sous
forme de bibliothèques partagées .NET et recompilés *juste-à-temps* à
l'exécution, ce qui permet d'atteindre la moitié des performances d'un code
natif en C++. Ces sous-classes peuvent en particulier redéfinir les méthodes
``Start()``, qui sert de constructeur, et ``Update()``, qui est appelée à chaque
affichage d'une image et qui permet par exemple d'animer un objet en interpolant
sa position en fonction du temps écoulé depuis le dernier appel [#]_. On peut
aussi réagir à différents évènements en implémentant les méthodes dont le nom
commence par ``On`` [#]_. Ainsi ``OnGUI()`` est appelée à chaque événement
d'entrée de l'utilisateur et ``OnTriggerEnter()`` est déclenché lorsque
l'utilisateur entre dans une zone prédéfinie.

.. [#] il s'agit en fait d'une version plus stricte que la norme ECMA ou toutes
        variables doivent être typés (pour des raisons de performance).
.. [#] ce qui leur permet d'accéder à une grande part de l'API .NET, celle
        implémentée par le projet Mono et présente ainsi l'avantage d'être
        disponible sur d'autre plateforme que Windows.
.. [#] décrit comme un mélange entre python et C# par son créateur [BOO2005]_, et
        que j'aurais bien essayé par curiosité mais qui est manifestement très peu
        utilisé par la communauté ce qui réduit l'aide disponible.
.. [#] pour une simulation physique, on peut aussi utiliser ``OnFixedUpdate()``
        qui est appelé à intervalle constant.
.. [#] la liste complète est disponible `ici
        <http://unity3d.com/support/documentation/ScriptReference/MonoBehaviour.html>`_
.. [BOO2005] http://boo.codehaus.org/BooManifesto.pdf

À ce stade, le lecteur est normalement impatient d'avoir un exemple de ces
fameux scripts. Outre ceux fournis avec Unity pour le déplacement d'un
personnage à la souris et au clavier (que Géraud a un peu adapté pour qu'il
permette de voler), le premier qu'il a écrit concerne la transition entre la
visite de la chapelle et l'observation d'un objet en particulier. Le code
commenté est disponible en annexe mais schématiquement, à chaque image, on lance
un rayon à partir de la position du visiteur dans la direction de son regard. Si
celui-ci intersecte l'objet en question, on allume un projecteur pour signaler
la possibilité d'une interaction. Si l'utilisateur clique, on lance animation
qui l'amène progressivement en face de l'objet tandis que le reste de la scène
s'assombrit jusqu'à disparaitre. Une fois arrivé, on affiche divers éléments
contextuels en prenant soin de désactiver les contrôles de mouvements. Unity
permet aussi d'envoyer des requêtes à un serveur web par l'intermédiaire de la
classe `WWWForm
<http://docs.unity3d.com/Documentation/ScriptReference/WWWForm.html>`_. Géraud a
exploité cette possibilité en écrivant deux petits scripts PHP qui permettent de
laisser un commentaire sur l'objet et de récupérer ceux des visiteurs précédents
qui sont affichés à l'écran. Quand l'utilisateur en à terminer, il lui suffit de
cliquer pour que la transition se rejoue à l'envers et le ramène à sa situation
précédente.

Enfin, cette semaine s'est conclue par une visite à la vraie chapelle et au
musée attenant, situés dans la vielle ville de Québec, ce qui a permis de donner
une substance à nos travaux.

Recréation du modèle
~~~~~~~~~~~~~~~~~~~~

Parallèlement, Camille s'est attelée à reconstruire un modèle de la chapelle à
l'aide d'une version d'essai du logiciel 3D-Coat. En effet, j'avais essayé
d'importer une des tranches dans Unity, mais le résultat était décevant car les
surfaces sensées être plane étaient bruité ce qui dégradait l'éclairage. De
plus, par défaut, Unity ne permet pas d'exploiter l'information de couleur
associée à chaque sommet et affichait donc une teinte uniforme, ce qui n'était
pas acceptable. Enfin, cet affichage médiocre n'était pas très performant car
chaque seizième de chapelle comportait environ 250000 faces (plus que l'ensemble
du modèle complet que nous avons obtenu ultérieurement).

3D-Coat permet donc de charger ce modèle polygonal trop détaillé afin de
redessiner une surface qui s'appuie dessus. C'est un processus manuel, donc long
et fastidieux, mais il permet de choisir le niveau de détail de chaque zone ce
qui donné un résultat plus léger et mieux adapté. Malgré une machine
performante, 3D-Coat n'a pas supporté de charger l'ensemble de la chapelle et il
a donc fallu effectuer la retopologie tranche par tranche. C'est d'autant plus
frustrant que nous avons spontanément commencé par les tranches du cœur avant de
constater arrivé à la fin, qu'elles étaient les moins réussies, ce qui a forcé
Camille à les refaire. Cette manière de procéder a aussi nécessité de recoller
les différents morceaux entre eux, ce qui n'était pas trivial car ils n'avaient
pas forcément la même géométrie aux extrémités (par exemple un mur pouvait être
constitué de cinq bandes d'un côté et seulement trois de l'autre). Géraud a pour
cela utilisé le logiciel Blender [#]_, qui a servi par la suite pour le plaquage
de textures. C'est en effet la méthode la plus simple pour obtenir un bon rendu
dans Unity et s'il était aussi possible de le faire dans 3D-Coat (de manière
plus intuitive semble-t-il), le résultat était moins bon. Succinctement, cela
consiste à déplier le modèle 3D afin de faire correspondre les coordonnées
*(x,y,z)* de chaque sommet avec un point *(u,v)* [#]_ d'une image qui fournit
l'information de couleur (dans notre cas, il s'agissait d'images de l'intérieur
de la chapelle prises par Luc-Antoine Couturier).

.. [#] un logiciel de modélisation et d'animation, qui est, à l'instar de Linux,
        Firefox, GIMP, ou encore LibreOffice, un des fleurons du mouvement
        libre.
.. [#] d'où le nom d'*UV mapping* de cette technique.

C'est d'ailleurs à ce stade que nous avons constaté qu'il nous manquait des
photos de la nef, ce qui nous a amené à réaliser une autre campagne dans la
chapelle. Cela nous a aussi permis de scanner la façade extérieur, la chapelle
publique et le sanctuaire (voir plan [#]_) afin d'intégrer notre travail à un
modèle 3D de la ville et de contextualiser l'arrivée du visiteur dans la
chapelle privée. C'est alors posé la question du mobilier et des autels. En
effet, le scan de 2010 ayant eu pour but de capter le bâtiment, la résolution
n'était pas adapté à la taille de ces objets, et les traitements ultérieurs
n'ont fait qu'empirer les choses. En ce qui concerne les meubles, nous avons
décidé de les modéliser directement dans Blender, en s'appuyant sur le nuage de
points pour les dimensions et sur des photos pour les détails [#]_. La décision
a en revanche été plus délicate à prendre car deux écoles s'affrontaient [#]_.
Nous avions le choix entre scanner avec une meilleure précision ou utiliser la
photogrammétrie.

.. [#] TODO mettre un plan
.. [#] tout en sachant que ces objets devant par la suite être dupliqué en
        dizaine d'exemplaires, (à l'aide d'un script, voir annexes), ils ne
        doivent pas comporter trop de sommets.
.. [#] TODO elles s'affrontent toujours d'ailleurs…

Photogrammétrie
~~~~~~~~~~~~~~~

Introduction
____________

De nos jours, une grande partie de la surface de la Terre est accessible sous
forme de photographies numériques, que ce soit grâce au déploiement de
satellites ou la généralisation des appareils photos numériques et des
smartphones, voire aux efforts de certaines sociétés commerciales. En revanche,
malgré leur indéniable perfectionnement technologique, les scanneurs 3D restent
des appareils onéreux et généralement peu maniable, ce qui les confine pour
l'instant au domaine professionnel, où ils sont notamment utile en métrologie.
Partant de ce constat, et tenant compte de l'attractivité de la troisième
dimension pour le grand public, il parait logique d'essayer de reconstruire un
objet en 3D à partir de photos pris sous différents angles, ce qui est le but de
la photogrammétrie. Afin d'appliquer cette méthode, Géraud a testé plusieurs
solutions qui se basent toute sur un principe similaire.

Principe
________

Dans un premier temps, il faut relier les photos entre elles. Cela ne peut se
faire que si elles respectent plusieurs contraintes [#]_ : le fond de l'image
doit rester constant au cours des prises de vue – qui doivent préférablement
s'effectuer avec le même appareil et les mêmes réglages. Il doit – ainsi que
l'objet – présenter des textures variées et pour les photos se recoupent le
mieux possible, il ne faut éviter qu'elle soit séparées de plus de dix degrés
[#]_.  Dans ces conditions, on peut en extraire une caractérisation grâce à la
méthode SIFT. Cela peut être réalisé avec un logiciel développé par David Lowe.
Cette méthode est aussi intégrée au logiciel `Bundler
<http://phototour.cs.washington.edu/bundler/>`_, qui l'effectue après un pré
traitement des images [#]_, et on peut supposer qu'elle est aussi utilisé par
Photosynth [#]_ dont il sera question plus loin. À noter qu'il existe des
alternatives à SIFT, notamment la méthode SURF, qui se présente comme plus
robuste et dont il existe de nombreuses implémentations open source [opensurf]_.

.. [#] dont un des sites donne `une liste imagée
        <http://my3dscanner.com/index.php?option=com_k2&view=item&id=54:a-must-read-top-8-mistakes-of-our-users&Itemid=72>`_.
.. [#] ou formulé autrement, deux photos consécutives doivent présenter au moins
        80% de contenu en commun.
.. [#] détermination de la focale en fonction des données EXIF,
        redimensionnement, …
.. [#] puisque Bundler a été développé dans le cadre du projet `Photo tourism
        <http://phototour.cs.washington.edu/>`_ mené par Microsoft qui vise à exploiter
        les nombreuses des monuments célèbres disponibles sur internet pour en donner
        une représentation 3D.
.. [opensurf] Notes on the OpenSURF Library

Une fois qu'on dispose de ces points de correspondance, on peut déterminer
l'orientation relative des photos grâce aux principes de stéréovision. On peut
ensuite trianguler la position des points  de correspondances à partir de la
position des différentes caméras, dont on connaît idéalement la distance focale.
Voir le chapitre 7 de *Computer Vision: Algorithms and Applications*, Richard
Szeliski pour plus de détails.

Solutions testées
_________________

* MICMAC : développé par l'IGN pour traiter des photos satellites, cela semble
  une solution robuste mais plus adaptée à des dimensions larges et surtout très
  difficile d'accès car comme le dit l'article de présentation [micmac]_ : «*it
  is probably more complex but also more complete, its targeted user is rather
  professionals (architects, archaeologist, geomophologist) than people*».
  Effectivement, sorti des exemples, Géraud n'a pas eu le courage de modifier
  les cinq cents ligne du fichier de configuration en XML.

.. [micmac] micmac

* 3DSOM Pro : logiciel de la société Creative Dimension Software Ltd qui donnait
  aussi de très bons résultats sur les photos fournis à titre de démonstration
  [#]_.
  Malheureusement, la version d'essai était limitée à 14 jours, ne permettait
  pas d'exporter les modèles obtenus et coûtait 1349$ pour être débloquée.

.. [#] qui avaient manifestement été obtenues dans de très `bonnes conditions
    <http://www.3dsom.com/features/process.html>`_.

* CVMS et PVMS2 : ensemble de logiciels [#]_ qui exploitent la sortie de
  Bundler. `CVMS <http://grail.cs.washington.edu/software/cmvs/>`_ sert à
  préparer les données pour un traitement par lot sur un cluster tandis que
  `PVMS2 <http://grail.cs.washington.edu/software/pmvs/>`_ reconstitue
  effectivement un nuage de points dense. La configuration n'est `pas trop
  compliquée <http://grail.cs.washington.edu/software/pmvs/documentation.html>`_
  mais les résultats n'étaient pas très complet mais sollicitaient en revanche
  lourdement la machine pour être obtenus.

.. [#] des binaires pour windows sont disponibles sur ce `site
        <http://opensourcephotogrammetry.blogspot.fr/>`_.

* VisualSFM  : il s'agit d'une `interface graphique
  <http://www.cs.washington.edu/homes/ccwu/vsfm/>`_ au deux logiciels précédents
  qui présente donc les mêmes défauts et les mêmes qualités.

* PhotoSynth Toolkit : `Solution
  <http://www.visual-experiments.com/tag/photosynthtoolkit/>`_ développée par un
  ingénieur français sur son temps libre et qui consiste à utiliser le service
  PhotoSynth de Microsoft pour extraire les relations entre les images et les
  fournir en entrée à PVMS. Là encore, les résultats semblaient prometteurs mais
  le logiciel ne s'exécutait que sur windows 64 bit que seul le portable de
  Géraud possédait et qui n'est pas malheureusement pas assez puissant pour
  traiter plus d'une vingtaine de photos en un temps raisonnable [#]_.

.. [#] c'est-à-dire qui ne se compte pas en dizaines d'heures d'écran noir et de
        processeur chauffant comme les forges de l'enfer.

Reste les solutions en lignes, qui ne présente pas cet inconvénient :

* My 3D scanner : service gratuit qui récupère au plus 200 Mo de photos d'un
  objet [#]_ et en propose — après quelques heures d'un traitement qui se base
  notamment sur les `incontournables Bundler et PVMS
  <http://www.my3dscanner.com/index.php?option=com_k2&view=item&id=58:how-it-works&Itemid=57>`_
  —  une version en nuage de points et un modèle polygonal sur lequel on peut
  transférer la couleur des points individuels.

.. [#] voir une vidéo, ce qui permet d'exploiter les techniques de structures
        from motion.

* ARC 3D : Un  service de même nature est `proposé
  <http://homes.esat.kuleuven.be/~visit3d/webservice/v2/index.php>`_ par
  l'université de Louvain. Il se distingue par son intégration poussée avec
  Meshlab [arc3d]_ qui permet de régler différents paramètres de la reconstruction et par
  le fait que le modèle polygonal est *UV-mappé* sur les photos d'entrée, même
  si cela reste impossible à manipuler à la main.

.. [arc3d] Web-based 3D Reconstruction Service

Notons enfin qu'il existe de nombreuses autres solutions référencées dans ce
`forum <http://pgrammetry.com/forum/>`_ ou plus simplement sur `wikipédia
<http://en.wikipedia.org/wiki/Photogrammetry#Current_suite_of_software>`_.

Récapitulatif
_____________

==================      ========  =====================         =============  ==========
Système                 Type      Licence et coût               Documentation  Résultat
==================      ========  =====================         =============  ==========
MICMAC                  logiciel  GPL, gratuit                  succincte      N/A
3DSOM                   logiciel  propriétaire, 1349$           N/A            N/A
PVMS2                   logiciel  GPL, gratuit                  suffisante     très lourd
VisualSFM               logiciel  GPL, gratuit                  suffisante     lourd
PhotoSynth Toolkit      logiciel  mixte, gratuit                suffisante     lourd
My 3D scanner           web       propriétaire, gratuit         imagée         bon
ARC 3D                  web       propriétaire, gratuit         fournie        bon
==================      ========  =====================         =============  ==========

Animation
~~~~~~~~~

En sus de l'interactivité, on peut rendre le modèle plus crédible et donc plus
immersif en y ajoutant du mouvement. Il faut toutefois garder à l'esprit que
l'atmosphère de recueillement qui imprègne le lieu empêche de se lancer dans une
débauche d'effets cinématique. Nous avions donc considérer initialement trois
type de mouvements : l'ouverture et la fermeture des portes lors des entrées et
sorties afin d'augmenter le réalisme, le déplacement d'une barre pour les genoux
sous les sièges, ce qui permet de mieux appréhender l'objet et enfin le
mouvement des pages d'un livre qu'on tourne.

C'est aussi l'occasion de présenter trois méthodes d'animation disponible sous
Blender qui s'exportent avec des fortunes diverses sous Unity.

* images clés : la plus simple des trois, qui est d'ailleurs disponible
  directement dans Unity. Elle consiste à choisir la propriété numérique que
  l'on veut voir varier au cours du temps (la position en x du centre de gravité
  de l'objet ou la composante rouge de son matériau), lui donner des valeurs à
  certains temps clé [#]_ et à interpoler entre ces différents instants [#]_.
  Cela convient bien à des mouvements de solides rigides et on peut s'aider d'un
  objet qui sert de chemin pour suivre des trajectoires complexes. En revanche,
  tous les sommets de l'objet conservent leur position relative. Si l'on veut
  lui faire subir des déformations, il faut donc se tourner vers une des autres
  méthodes.

.. [#] l'unité de temps étant la *frame* (d'où encore une fois le nom de la
        technique), qu'on retrouve 24 ou 60 fois par seconde, et qui permet de faire
        varier la vitesse de l'animation suivant les besoins.
.. [#] on peut choisir entre une interpolation constante, linéaire ou de bézier.

* squelette : on attache à l'objet un squelette composé de différents os
  organisés de façon hiérarchique [#]_. Chacun de ces os affectent chaque sommet
  avec un poids compris entre 0 et 1 (la situation la plus simple étant celle ou
  tous les poids valent soit 0 soit 1, ainsi à chaque os est associé un ensemble
  unique de sommets). On fait alors bouger chaque os avec la technique des
  images clés et l'objet se déforme pour suivre son squelette. C'est évidemment
  une technique particulièrement employée pour les personnages de jeux vidéo
  [#]_ donc elle bien supportée par Unity.

.. [#] les os fils « subissent » les rotations des os desquelles ils descendent
        (ceux à qui ils sont attachés par la tête).

.. [#] puisqu'outre son aspect intuitif, on peut la combiner avec la *motion
        capture* ou la cinématique inverse, qui consiste à spécifier les
        positions finales des os terminaux et laisser le logiciel calculer les
        mouvements des os intermédiaires.

* *vertex morphing* [#]_ : Cette dernière méthode consiste à stocker différente
  version d'un modèle, qui diffère par la position relative de certains sommets.
  Ces versions sont appelées *morph target* et à l'affichage de l'objet, on
  réalise une combinaison linéaire de certaines *morph target* pour obtenir la
  position effective de tous les sommets de l'objet. Pour reprendre l'exemple
  d'un jeu vidéo, un artiste peut réaliser des versions mâle, femelle, grosse et
  maigre du personnage et via des curseurs, le joueur peut ainsi personnaliser
  la morphologie de son avatar. C'est toutefois une méthode moins
  anthropomorphique que l'animation squelettale qui peut donc s'adapter à une
  classe plus large d'objets. En revanche, elle n'est pas supportée nativement
  par Unity. Il existe un `plugin pour Blender
  <http://rezzable.com/metamorph>`_, qui ne fonctionne pas avec la dernière
  version et qui donc été assez laborieux à mettre en place. Géraud a essayé de
  l'utiliser pour corner les pages du livres en train de se tourner mais il
  stocke les déplacements des sommets dans une image (dont les composantes
  rouge, vert, bleu représente un vecteur) dont la résolution n'était compatible
  avec la finesse des pages, ce qui donnait un résultat décevant.

.. [#] qu'on pourrait traduire par « déformation de sommets », mais aucune
        personne saine d'esprit ne s'y risquerait.

Le panoscope
~~~~~~~~~~~~

L'immersion dépend en grande partie de dispositif d'affichage utilisé. Même s'il
n'est pas rare de croiser des gens totalement absorbés par l'écran de 15 cm² de
leur téléphone, plus l'affichage se rapproche de la vision naturelle, plus
l'impression de réalisme est renforcée. À ce titre, le LAMIC dispose, outre des
projecteurs balayant les 4 murs d'une vaste pièce blanche, d'un `panoscope
<http://tot.sat.qc.ca/dispositifs_panoscopes.html.>`_ Il s'agit d'un écran
hémisphérique rigide qui enveloppe l'utilisateur pour recouvrer tout son champ
de vision. Il combiné à un projecteur hémisphérique situé au centre du cercle
supérieur. Dès lors se pose la question de la méthode à employer pour exploiter
cet écran exotique.

Comme nous l'a expliqué `Sébastien Roy
<http://www.iro.umontreal.ca/~roys/fr_index.shtml>`_, il « suffit » [#]_ de
projeter la géométrie de l'écran à plat et d'y plaquer une image qui va
compenser la déformation. On peut donc réutiliser la méthode de l'UV mapping et
c'est d'ailleurs ce qu'a fait la SAT. Géraud a récupéré un projet Unity qui
mettait cette technique à l'œuvre : cinq caméras attachées au point de vue
filmait la scène vers la gauche, la droite, le haut, le bas, l'avant et
l'arrière et plaçait le résultat dans une *RenderTexture*. Ces textures étaient
alors appliquées à la bonne position sur un cercle aplatit représentant le dôme,
qui était à son tour filmé par la caméra principale.

.. [#] sauf que ça va faire un mois et demi, et que ça ne marche pas mieux qu'au
        premier jour. L'un des problèmes et qu'il faut utiliser la résolution native du
        projecteur pour un résultat optimal, ce que Mac OS se refuse à faire avec un
        acharnement qui confine à l'insolence. L'autre écueil étant que la projection UV
        doit compenser les distortions de la lentille, ce qui nécessite des informations
        assez précises.

Nuage de points
~~~~~~~~~~~~~~~

La matière première de notre modélisation, à part les cas simples où une photo
de profil suffisait, a constitué en des nuage de points. Il existe de
`nombreuses méthodes
<http://fr.wikipedia.org/wiki/Scanner_tridimensionnel#Techniques_de_collecte_de_données>`_
pour scanner un objet en 3D. Ainsi, MCG3D utilise `un produit conçu par Arius3D
<http://www.arius3d.com/a3dscanner.html>`_, qui est un scanner sans contact
actif par triangulation laser fournissant en sortie trois coordonnées spatiales
par points associées à une couleur. Ces techniques ont toutefois en commun de ne
fournir qu'un échantillon des sommets qui constitue l'objet, sans pouvoir
capturer d'information sur la surface continue qui les relie. Or la solution la
plus courante (et donc devenue la plus riche et la plus performante au fil du
temps) pour afficher des objets en synthèse d'image se base sur des modèles
polygonaux [#]_, ce qui nécessite un post traitement qui s'est avéré
particulièrement ardu et chronophage.

.. [#] même si dans une perspective artistique, on peut essayer de travailler
        l'esthétique du nuage de points.

Affichage tel quel
__________________

Les fichiers fournis par MCG3D étaient dans un format simplissime : chaque ligne
contient les trois coordonnées d'un point et son intensité suivant les trois
composantes rouge, verte et bleue. Une idée tout aussi simple est alors de lire
ce fichier ligne à ligne et d'ajouter à chaque fois la particule correspondante
à un système de particules `disponible
<http://docs.unity3d.com/Documentation/ScriptReference/ParticleSystem.html>`_
dans Unity. Malheureusement, si le résultat est globalement celui auquel on
s'attend [photo], les performances sont déplorables (8 images par seconde
pour 350 000 points alors que la chapelle intérieure à la résolution de 2mm en
contient plus de quatre millions) et l'affichage intermittent. Une des solutions
est de ne conserver qu'un point sur *n*, car même si cette approche paraît un
peu brutale, un `exemple sur internet
<http://scotland.proximity.on.ca/asalga/demos/freecam/>`_ semblait prometteur.
On pourrait aussi essayer de découper le nuage entier en sous cubes pour
n'afficher que ceux qui sont dans le champ de vision de l'utilisateur.

Triangulation
_____________

Les scans sont tellement détaillés que l'œil humain n'a aucun mal à en extraire
une représentation surfacique. À titre d'exemple, nous avons mené nos premiers
essais sur l'autel droit issu du scan de 2010 qui compte 130 000 points, avant
de récupérer une version fusionnée du scan de 2012 de près de 900 000 points.
Mais ce n'est manifestement pas l'avis de l'ordinateur, d'abord à cause du bruit
de mesure, qui perturbe les surfaces planes [#]_. Ensuite parce qu'à cause des
occlusions, il faut scanner les objets sous différents angles et que la réunion
de ces données multiples introduit de nouvelles ambigüités. C'est
particulièrement flagrant sur l'autel, qui possède des formes organiques assez
fines.

.. [#] problème que l'on peut atténuer en utilisant un filtre médian, au prix de
        la perte de détails.

Nous avons utilisé deux logiciels pour essayer d'obtenir des polygones à partir
d'un nuage de points, même s'il en existe bien d'autres, comme `Geomagic
<http://www.geomagic.com/en/products/wrap/overview/>`_ présenté de façon
impressionnante lors d'une réunion chez Creaform.

* Polywork : utilisé par MCG3D et dont le LAMIC possède la version 2010. C'est
  `un logiciel complexe destinée à l'industrie
  <http://www.innovmetric.com/polyworks/3D-scanners/home.aspx?lang=en>`_. À
  force d'essais, nous avions abouti à un modèle probant de 1,7 millions de
  faces, qui possédait malheureusement l'agaçant défaut de ne pas avoir toutes
  ses faces orientées du même sens, ce qui était difficile à corriger, tant
  manuellement qu'automatiquement. [photo ?]

* `Meshlab <http://meshlab.sourceforge.net/>`_ : initialement développé au sein
  de l'université de Pise par des étudiants en informatique, il implémente de
  nombreuses techniques concernant les maillages parues dans des articles
  universitaires. On peut ainsi calculer les normales des points [#]_ à partir
  de ses voisins avant d'effectuer une reconstruction de Poisson [#]_ et de
  transférer les couleurs des points à la face dont ils sont les plus proches. Là
  encore, les résultats ne sont pas ridicules mais jurent avec la modélisation
  soignée du chœur de la chapelle.

.. [#] qui correspond grosso modo à la moyenne des normales des faces contenant
        ce point dans le polygone convexe enveloppant le nuage.
.. [#] détailler la méthode ?

Ces méthodes étant assez gourmandes en ressource, il nous a paru plus prudent de
procéder autrement pour les nuages correspondants à l'extérieur (2,3 millions de
points), à l'intérieur de la chapelle publique (4,5M) et au sanctuaire (2,8M),
d'autant que ce sont des zones qui ne sont pas prioritaires [#]_. En
l'occurrence, en utilisant Blender, on crée une esquisse plane qui reprend les
grands traits de la structure considérée [#]_, on la subdivise en utilisant
l'algorithme de `Catmull-Clark
<https://en.wikipedia.org/wiki/Catmull–Clark_subdivision_surface>`_ pour
affiner sa précision, on projette chacun de ses sommets sur le sommet le plus
proche dans le nuage et on effectue un filtre médian pour adoucir le résultat et
enlever les points aberrants. Le résultat peut évident s'avérer assez éloigné de
la réalité, mais suffit à en fournir une illusion satisfaite et la surface
obtenue est d'une grande régularité [photo].

.. [#] même s'il serait aussi tentant de les afficher directement en points.
.. [#] puisque selon Thierry Moszkowicz, la détection d'arêtes en 3D est un
        problème délicat, alors même qu'il est bien maitrisé en 2D et qu'on
        possède des informations de couleur.
