
.. vim: tw=80 spell:

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
        <unity3d.com/support/documentation/ScriptReference/MonoBehaviour.html>`_
.. [BOO2005] http://boo.codehaus.org/BooManifesto.pdf

À ce stade, le lecteur est normalement impatient d'avoir un exemple de ces
fameux scripts. Outre ceux fournis avec Unity pour le déplacement d'un
personnage à la souris et au clavier (que j'ai un peu adapté pour qu'il permette
de voler), le premier que j'ai écrits
