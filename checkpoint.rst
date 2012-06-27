
.. vim: tw=80 spell:

Compte rendu à mi parcours
==========================

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
(écrite en C++) encapsule l'utilisation de OpensceneGraph pour la visualisation
3D, OpenSoundControl pour la communication réseau et la téléprésence, ainsi que
python pour le scripting et les interactions. Le tout était piloté par un
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
et de se baser sur Unity pour la visualisation et l'interaction. Je ne dirais
que quelques mots du premier processus car il était plutôt du ressort de
Camille.

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
demi-tours instatanés quel que soit sa masse et sa vitesse ou le *rigidbody*,
plus conforme à la science (ou du moins à sa version simulée). La `liste complète
<http://unity3d.com/support/documentation/Components/index.html>`_ est
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
``Start()``, qui sert de constructeur, et ``Upadte()``, qui est appelée à chaque
affichage d'une image et qui permet par exemple d'animer un objet en interpolant
sa position en fonction du temps écoulé depuis le dernier appel [#]_. On peut
aussi réagir à différents évenements en implémentant les méthodes dont le nom
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
personnage à la souris et au clavier (que j'ai un peu adapté pour qu'il permette
de voler), le premier que j'ai écrit concerne la transition entre la visite de
la chapelle et l'observation d'un objet en particulier. Le code commenté est
disponible en annexe mais schématiquement, à chaque image, on lance un rayon à
partir de la position du visiteur dans la direction de son regard. Si celui-ci
intersecte l'objet en question, on allume un projecteur pour signaler la
possibilité d'une interaction. Si l'utilisateur clique, on lance animation qui
l'amène progressivement en face de l'objet tandis que le reste de la scène
s'assombrit jusqu'à disparaitre. Une fois arrivé, on affiche divers éléments
contextuels en prenant soin de désactiver les contrôles de mouvements. Unity
permet aussi d'envoyer des requêtes à un serveur web par l'intermédiaire de la
classe `WWWForm
<http://unity3d.com/support/documentation/ScriptReference/WWWForm.hmtl>`_. J'ai
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
l'aide d'une version d'essai du logiciel 3Dcoat. En effet, j'avais essayé
d'importer une des tranches dans Unity, mais le résultat était décevant car les
surfaces sensées être plane étaient bruité ce qui dégradait l'éclairage. De
plus, par défaut, Unity ne permet pas d'exploiter l'information de couleur
associée à chaque sommet et affichait donc une teinte uniforme, ce qui n'était
pas acceptable. Enfin, cet affichage médiocre n'était pas très performant car
chaque seizième de chapelle comportait environ 250000 faces (plus que l'ensemble
du modèle complet que nous avons obtenu ultérieurement).

3Dcoat permet donc de charger ce modèle polygonal trop détaillé afin de
redessiner une surface qui s'appuie dessus. C'est un processus manuel, donc long
et fastidieux, mais il permet de choisir le niveau de détail de chaque zone ce
qui donné un résultat plus léger et mieux adapté. Malgré une machine
performante, 3Dcoat n'a pas supporté de charger l'ensemble de la chapelle et il
a donc fallu effectuer la retopologie tranche par tranche. C'est d'autant plus
frustrant que nous avons spontanément commencé par les tranches du cœur avant de
constater arrivé à la fin, qu'elles étaient les moins réussies, ce qui a forcé
Camille à les refaire. Cette manière de procéder a aussi nécessité de recoller
les différents morceaux entre eux, ce qui n'était pas trivial car ils n'avaient
pas forcément la même géométrie aux extrémités (par exemple un mur pouvait être
constitué de cinq bandes d'un côté et seulement trois de l'autre). J'ai pour
cela utilisé le logiciel Blender [#]_, qui a servi par la suite pour le plaquage
de textures. C'est en effet la méthode la plus simple pour obtenir un bon rendu
dans Unity et s'il était aussi possible de le faire dans 3Dcoat (de manière plus
intuitive semble-t-il), le résultat était moins bon. Succinctement, cela
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

Animation
~~~~~~~~~

Le panoscope
~~~~~~~~~~~~
