Puisque le projet avait débuté dès 2010, la première semaine a en
partie été consacré à se familiariser avec le travail réalisé
par Elsa. Celui-ci souffrait néanmoins de deux problèmes. D'abord,
alors qu'il fonctionnait à son départ, ce n'était plus le cas à notre
arrivée. En outre, ce dysfonctionnement était difficilement à diagnostiquer
car malgré l'important effort de documentation réalisé, le système
était un assemblage hétérogène de plusieurs logiciels et langages. Il
s'appuyait sur une plateforme linux qui exécutait, outre un serveur audio
et un serveur DHCP, un ensemble de composants développés par la SAT :
`SPIN <http://spinframework.org/content/overview>`_. Cette bibliothèque
libre (écrite en C++) encapsule l'utilisation de OpensceneGraph pour la
visualisation 3D, OpenSoundControl pour la communication réseau et la
téléprésence, ainsi que python pour le scripting et les interactions. Le
tout était piloté par un interface en pure data à l'aide de `pdsheefa
<http://code.sat.qc.ca/redmine/projects/pdsheefa/wiki/About>`_. Autant dire
que les messages d'erreur étaient pour le moins perdus dans ces diverses
couches et donc assez ardus à exploiter. Pour assombrir encore le tableau,
tous ces logiciels étaient restés dans leur version de l'été 2011 et
mes essais de mis à jour n'ont fait que rajouter des incompatibilités.

Même si ces écueils auraient sans doute pu être surmontés à force
de persévérance, les efforts à fournir semblaient disproportionnés en
comparaison des résultats attendus. En effet, au-delà des soucis technique,
le modèle de la chapelle utilisé jusque-là ne donnait pas une entière
satisfaction. Suivant les recommandations de notre maitre de stage et de
M. Vesac, nous avons donc décidé de repartir sur de nouvelles bases (en
espérant que d'éventuels futurs stagiaires n'aient pas à emprunter une
troisième voie l'année prochaine…). En l'occurrence, il s'agissait de
reconstruire le modèle à partir du scan initial et de se baser sur Unity
pour la visualisation et l'interaction. Je ne dirais que quelques mots du
premier processus car il était plutôt du ressort de Camille.

`Unity <http://unity3d.com/unity/>`_ est à la fois un moteur de rendu temps
réel, un intégrateur de contenus multimédias et un éditeur/compilateur
de code. `D'après <http://fr.wikipedia.org/wiki/Unity_(moteur_de_jeu)>`_
wikipédia, on peut le comparer à Virtools, à l'UDK ou au CryEngine. S'il
est majoritairement utilisé pour réaliser des jeux vidéos, il est aussi
utilisé dans le domaine de l'architecture ou de l'éducation. Basé sur de
nombreuses technologies libres (OpenGL, Mono [#]_, OggVorbis, Boo, theora,
zlib, png, curl, scite, freetype, …), il est néanmoins propriétaire et peut
donc aussi intégrer le moteur PhysX de Nvidia pour la simulation physique. Il
existe une version gratuite qui ne permet pas d'accéder à l'ensemble des
fonctionnalités de la version professionnelle, facturée 1150€ — et qui
s'est avérée nécessaire pour réaliser la projection dans le panoscope,
voir plus loin. Il est possible d'exporter ses résultats sous forme de
binaires pour Windows, MacOS (et Linux dans la future version 4) ainsi qu'en
flash et dans un format destiné à un plugin web spécifique. Moyennant une
nouvelle contribution à la cause, on peut aussi exporter vers iOS et Android.

.. [#] c'est bizarre à dire, mais c'est libre aussi…
