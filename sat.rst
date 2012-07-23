Chronique d'un succès mitigé
============================

**Jeudi 19 juillet a été archivée sur une clé USB une version représentant les
derniers avancements du projet Unity contenant le modèle de la chapelle ainsi
que les premières interactions associées. Cette archive a ensuite été transférée
sur l'ordinateur d'Ambroise où elle s'est exécutée sans qu'aucun problème
nouveau ne se fasse jour** (ou plutôt nuit, étant donnée l'heure tardive à
laquelle cette démonstration a eu lieu).

**Ce qui suit est le récit de l'exécution du ce même projet sur les ordinateurs de
la SAT [#]_ à Montréal, qui différent par leur système de projection
(satosphère) et de contrôle (par iphone, car les machines sont trop éloignées de
l'affichage), ce qui s'est révélé nettement moins simple.** En raison
de l'état de choc des témoins à l'issue de cette expérience exigeante, les heures
ne sont fournies qu'avec une grande incertitude.

.. [#] `Société des arts technologiques <http://www.sat.qc.ca/>`_

- 8h45 : avec un synchronisme surnaturel, toute l'équipe se retrouve devant les
  portes de la SAT, sauf Ambroise, parti étancher sa soif de caféine.

- 8h47 : constatant que la SAT est quasiment déserte, l'équipe décide de se
  porter au secours d'Ambroise qui est manifestement retenu en otage par une
  marchande de café intégriste qui n'aura pas supporté son crâne chauve.

- 8h55 : grâce au talent de négociateur de Philippe — et à une rançon sonnante
  et trébuchante —  Ambroise est libéré et cet événement joyeux est fêté autour
  d'un copieux déjeuner.

- 9h30 : de retour à la SAT, et constatant que la situation n'a guère évoluée,
  Ambroise décide d'aller taper du poing sur la table de qui de droit.
  Remarquant la fragilité de la caméra — et son poids, ne manqueront pas
  d'ajouter les mauvaises langues — Camille et moi préférons prudemment attendre
  son retour, non sans mettre à profit ce répit pour nous préparer
  psychologiquement aux tâches qui nous attendent.

- 9h55 : Alors que nous étions sensés être prêt à 10 heures, nous arrivons enfin
  devant les machines de la SAT, arrivée qui se déroule sous les pires auspices
  puisqu'il nous faut près de cinq minutes pour trouver le bon port où brancher la
  clé. C'est le début d'un calvaire interminable.

- 10h00 : **première déconvenue, après avoir importé le projet, aucun modèle ne
  s'affiche à l'écran. Blender étant installé sur la machine, il paraît
  raisonnable de penser qu'il s'agit d'un problème lors de l'export vers le
  format fbx que Unity réalise automatiquement. Après avoir mis à jour Blender,
  un export manuel confirme cette hypothèse. Cette fois, le modèle est visible
  mais les animations ne sont plus fonctionnelles. Surtout il faudrait
  réimporter tous les modèles à la main [#]_.** J'abandonne alors à regret la
  station de travail surpuissante de la SAT (Intel Xeon W3960 à 3,46 GHz, Nvidia
  quadro 6000, 24 Go de Ram) pour l'ordinateur d'Ambroise (qui est un Mac et un
  portable, donc qui n'est ni surpuissant, ni doté d'une souris).

.. [#] ce qui est réalisable, mais un peu long étant donné le retard déjà
        accumulé.

- 10h15 : **Pour tenir compte des particularités de la SAT, il faut importer
  deux packages unity supplémentaires ``OscController`` et ``Camera2012``. Ce
  dernier provoque malheureusement une erreur de compilation car il a des
  dépendances non satisfaites. Nous essayons alors d'installer le paquet
  manquant ``M2H Culling``, ce qui nécessite la création d'un compte et une
  connexion internet dont nous ne disposons pas. Il faut alors descendre d'un
  étage pour récupérer un câble réseau, ce qui nous permet de rencontrer
  Sébastien.**

- 10h30 : **Unity ne délivre les erreurs qu'au compte-gouttes, donc l'installation
  de ``M2H Culling`` ne sert qu'à faire apparaitre de nouvelles erreurs en
  relation avec le paquet ``OscController``.** Même Sébastien ne parvient pas à
  les régler et je décide dans un premier temps de supprimer tout le paquet pour
  me concentrer sur la caméra.

- 10h40 : **La caméra affiche l'image attendue mais elle ne se déplace pas avec
  le personnage alors que le script responsable de ce comportement ne fait
  qu'une ligne donc peut difficilement être erroné, ce qui laisse penser que le
  problème est bien plus subtil et bien mieux caché. Il parait alors plus simple
  d'importer la scène de départ de la SAT et d'y replacer nos objets. Néanmoins,
  même cette solution échoue, encore pour des problèmes de dépendances.**

- 10h55 : **Il apparait plus raisonnable d'importer notre modèle dans un projet
  vide (donc fonctionnel). Cela s'avère assez long car il faut exporter près de
  200 Mo de données avant de les réimporter juste après. Surtout, on y perd
  toutes les interactions car elles étaient basée sur une ancienne version du
  script ``Pointer`` dont les noms de fonctions ont changé.**

- 11h12 : Certaines personnes estiment le moment approprié pour émettre des
  remarques ironiques, qui ne sont bien sûr d'aucun secours mais contribuent à
  saper le moral des troupes.

- 11h30 : **Les modèles complets (sans les portes, dont l'ouverture dépend de la
  présence d'un personnage particulier qui n'est pas présent dans la scène de la
  SAT) et filaire sont disponibles. J'essaye de re faire fonctionner les scripts
  qui ajoutent le mobilier mais je m'emmêle et chaque banc ajouté essaye d'en
  créer dix autres derrière lui, ce qui finit par faire planter Unity, à court
  de mémoire.**

- 11h45 : **Ça y est, une version compilée est disponible, et Luc Courschene
  nous informe que nous disposons encore de la satosphère.** Il ne reste plus
  qu'à aller s'affaler sur les coussins et à profiter du spectacle.

- 12h00 : **Indépendamment de nous, les projecteurs de la SAT semblent
  récalcitrant, notamment à cause de la résolution choisie, ils se figent ou
  projettent trois images décalées.** Il nous faut donc prendre notre mal en
  patience jusqu'à ce les techniciens résolvent ces soucis, heureusement, nous
  avons eu l'occasion de nous entraîner à cette activité.

- 12h20 : **Enfin, la chapelle s'affiche dans toute sa splendeur mais
  malheureusement, nous sommes coincés dans un mur. Il faut donc descendre
  compiler une version où la position de départ du personnage est plus
  pertinente.**

- 12h30 : Avec seulement deux heures et demi de retard, on peut enfin visiter la
  chapelle dans la satosphère et même si les déplacements ne sont pas très
  intuitifs car on ne peut pas changer la direction de son regard, cela demeure
  une expérience réjouissante.

- 13h05 : Ambroise estime que ça fait trop longtemps que les gens de la SAT se
  tourne les pouces à l'étage d'en dessous et qu'il est largement temps d'aller
  compiler une nouvelle version pour observer le rendu du modèle filaire. En
  signe de soutien, je descends avec lui en arborant mon air le plus menaçant,
  effet réduit à néant par les larmes que me tirent mes quintes de toux.

- 13h10 : C'est un peu devenu la routine, et cette fois-ci, **le modèle
  fonctionne du premier coup.**

- 13h40 : Les gens de la SAT récupère la satosphère, ce qui tombe bien car à des
  degrés divers, tout le monde est taraudé par la faim.

Morale
______

- **Il aurait sans doute été plus simple de travailler en plus étroite collaboration
  avec la SAT afin de s'assurer d'avoir la dernière version de leur paquet Unity
  (ainsi que de leur application iPhone).**

- Certes les ordinateurs font tout ce qu'on leur dit, mais il faut le formuler
  distinctement et poliment.

- Si quelqu'un vous dit « T'inquiètes, il suffit de faire ça et ça, ça prendra
  cinq minutes », il est soit naïf, incompétent, prétentieux ou menteur mais
  dans tous les cas, ça prendra plus de cinq minutes.
