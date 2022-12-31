window.addEventListener("load", init);
var mark1; // marqueur placé par le joueur
var mark2; // cercle entre les 2 marqueurs
var mark3; // marqueur de la ville
var map; // map du jeu
var popup; // div qui contient les messages entre les manches
var ville; // tableau des villes du jeu qui contient leur noms, sources des images.
var random; // index de la ville choisi pour la manche courante
var nbVilles; // nombres totale de villes pour la partie
var btnPopup; // bouton de la popup qui permet de passer aux manches suivantes
var pointsPartie;
var AJouer; //boolean pour savoir si le joueur a jouer la manche
var AChrono; //boolean pour savoir si la parti est lancé avec le chrono
var id; //id qui permet de clear les appels du setIntervall de la progressBar entre les manches
function init() {
  var txtAnim = document.getElementById("title");

  var typewriter = new Typewriter(txtAnim, {
    delay: 0,
  });

  typewriter.typeString("Bienvenue sur notre jeu géographique !").start();

  popup = document.getElementById("popup");
  btnPopup = document.getElementById("btn");
  var BtnJouer = document.getElementById("lancerAvecChrono");
  var BtnJouerSansChrono = document.getElementById("lancerSansChrono");
  BtnJouer.addEventListener("click", chargerMap);
  BtnJouerSansChrono.addEventListener("click", chargerMap);
}
//function qui permet d'initialiser la map
function chargerMap(e) {
  if (e.target.id == "lancerSansChrono") AChrono = false;
  else AChrono = true;
  e.stopPropagation(); // éviter le bouillonement car plusieurs évenement click dans la map
  document.getElementById("map").style.boxShadow = "0px 0px 22px 8px black";
  map = L.map("map", {
    center: [46.9343, 1.9],
    zoom: 5.5,
    zoomControl: false,
  });
  //annulation de tous les evenements qui permettent de manipuler la map
  // car la map doit être fixé sur la france
  map.dragging.disable();
  map.touchZoom.disable();
  map.doubleClickZoom.disable();
  map.scrollWheelZoom.disable();
  map.boxZoom.disable();
  map.keyboard.disable();

  base = L.tileLayer(
    "https://stamen-tiles-{s}.a.ssl.fastly.net/toner-background/{z}/{x}/{y}{r}.{ext}",
    {
      subdomains: "abcd",
      minZoom: 0,
      maxZoom: 20,
      ext: "png",
    }
  ).addTo(map);
  redimensionnement();
  window.addEventListener("resize", redimensionnement);
  CommencerPartie();
}
//fonction qui permet de faire le responsive de la map
function redimensionnement() {
  if (window.matchMedia("(min-width:780px)").matches) {
    map.setZoom(5.5);
  } else {
    map.setZoom(5.4); //l'écart de zoom n'a pa pû etre mieux ajusté
  }
}
//function qui permet de récupérer les villes et leurs coordonné
//puis de commencer la partie avec la fonction jouer
function CommencerPartie() {
  recupVilles();
  var accueilJeu = document.getElementById("accueilJeu");
  accueilJeu.style.display = "none"; //on cache l'accueil du jeu
  pointsPartie = 0;
  document.getElementById("points").textContent = pointsPartie;
  montrerbtn();
  jouer();
}
//function qui permet de montrer le bouton qui permet de recommencer la partie depuis le début
function montrerbtn() {
  var recommencer = document.getElementById("recommencer");
  recommencer.style.display = "block";
  recommencer.addEventListener("click", btnPopupRejouer);
}
// fonction qui permet de récupérer les coordonnées des villes avec une
function recupVilles() {
  url = "./recupSQL.php";
  $.ajax({
    //requête web
    async: false,
    type: "GET",
    dataType: "json",
    url: url,
    success: function (retour) {
      ville = retour;
      nbVilles = ville.length;
    },
    error: function () {
      alert("PB avec l'URL");
    },
  });
}
//function qui permet de stocker la longitude et la lagitude de chaques villes avec leur noms avec une api
function recupCoordVille(nomVille) {
  var ville;
  url =
    "https://nominatim.openstreetmap.org/search?q=" +
    nomVille +
    "&format=json&polygon_geojson=1&addressdetails=1";
  $.ajax({
    //requête web
    async: false, //défaut
    type: "GET",
    dataType: "json",
    url: url,
    success: function (retour) {
      ville = {
        lon: retour[0].lon,
        lat: retour[0].lat,
      };
    },
    error: function () {
      alert("PB avec l'URL");
    },
  });
  return ville;
}

function jouer() {
  if (ville.length == 0)
    finJeu(); //si le tableau est vide toutes les villes ont été traité donc fin du jeu
  else {
    coup(); //sinon on passe à la ville suivante
  }
}
//fonction qui permet de demander à l'utilisateur une ville
function coup() {
  document.getElementById("manche").textContent = //affichage du numéro de la n-ième ville à deviner
    nbVilles - ville.length + 1 + "/" + nbVilles;
  random = Math.floor(Math.random() * ville.length); //tirage de la ville à deviner
  var nomVille = document.getElementById("nomVille");
  nomVille.textContent = ville[random].nom; //affichage du nom de la ville à deviner
  nomVille.style.display = "block";
  AJouer = false; //l'utilisateur n'a pas encore clicker
  if (AChrono) {
    //si l'utilisateur joue avec le chrono
    clearInterval(id); //on supprime les intervalles qui ont pu etre créer à la manche anterieur
    jauge(); //lancement du décompté de la jauge
  }
  map.addEventListener("click", clickMap); //activation de l'évenement de la map
}
//function qui permet de lancer le décompte de la jauge
function jauge() {
  const progressBar = document.getElementById("progressBar");
  const containerProgressBar = document.getElementById("containerProgressBar");
  containerProgressBar.style.display = "block"; //on affiche
  progressBar.style.width = "100%";
  const changeWidth = function (i) {
    if (AJouer == 0) {
      progressBar.style.width = i + "%";
      if (i == 0) btnPopupContinuer();
    }
  };
  var i = 100; //pourcentage de la with
  id = setInterval(function () {
    //id qui permet de clear les intervalles créer à la manche anterieur
    changeWidth(i--);
  }, 100); //on décrément la width tout les dixièmes de secondes
}
//function qui permet de traiter le click du joueur
function clickMap(e) {
  map.removeEventListener("click", clickMap); //on désactive l'évenement pour éviter que l'utilisateur reclick
  AJouer = true;
  mark1 = L.marker([e.latlng.lat, e.latlng.lng], {
    //on place le premier marker sur le click
    draggable: false,
  }).addTo(map);
  var coordVille = recupCoordVille(ville[random].nom); //coord gps de la ville choisi
  var dist = getDistanceFromLatLonInKm(
    //calcul de la distance entre les deux marqueurs
    e.latlng.lat,
    e.latlng.lng,
    coordVille.lat,
    coordVille.lon
  );

  setTimeout(function () {
    //après une demi-seconde on place le marqueur de la ville et on dessine le cercle
    mark2 = L.circle([e.latlng.lat, e.latlng.lng], dist * 1000, {
      //le rayon est donné par dist
      color: "rgb(159, 43, 161)",
      weight: 5,
      fillColor: "rgb(159, 43, 161)",
    }).addTo(map);
    mark3 = L.marker([coordVille.lat, coordVille.lon], {
      draggable: false,
    }).addTo(map);
  }, 500);

  var pointsManche = attribuerPoints(dist); //calcul des points gagnées
  pointsPartie += pointsManche;
  btnPopup.addEventListener("click", btnPopupContinuer);
  setTimeout(function () {
    //affichage du message après 2 secondes
    popup.style.display = "block";
    var msg = document.getElementById("msg");
    msg.innerHTML =
      "<h3 class='nb'>" +
      (nbVilles - ville.length + 1) +
      "/" +
      nbVilles +
      "</h3><h2 class='ville'>" +
      ville[random].nom + //récuperation du nom
      "</h2><img class='img' src=" +
      ville[random].img + //récupération de la source de l'image
      "><h2 class='distance'>Distance: " +
      Math.floor(dist) +
      "km</h2><h2 class='points'>Points: " +
      pointsManche +
      "</h2><h2 class='time'></h2>";
    btnPopup.textContent = "CONTINUER";
    document.getElementById("points").textContent = pointsPartie;
  }, 2000);
}
function attribuerPoints(Distance) {
  //distance en km
  var points = 0;
  if (Distance > 400) points += 0;
  else if (Distance > 300) points += 50;
  else if (Distance > 200) points += 100;
  else if (Distance > 100) points += 200;
  else if (Distance > 50) points += 400;
  else if (Distance > 25) points += 800;
  else if (Distance > 10) points += 1600;
  else if (Distance > 5) points += 3200;
  else if (Distance >= 0) points += 6400;
  return points;
}
//function qui permet de passer à la ville suivante
//appelé lors du click sur le bouton
//mais également lorsque l'utilisateur n'a pas clické et que le temps est écoulé si la jauge était activé
function btnPopupContinuer(e) {
  if (AJouer == 1) e.stopPropagation(); //on stoppe le bouillonement uniquement si la fonction a été appelé par le click du bouton
  removeLayer(); //on supprime les markers posés
  ville.splice(random, 1); //on supprime la ville des tableaux pour qu'elle ne passe qu'une seul fois
  popup.style.display = "none";
  jouer();
}
function removeLayer() {
  if (mark1 != null) map.removeLayer(mark1);
  if (mark2 != null) map.removeLayer(mark2);
  if (mark3 != null) map.removeLayer(mark3);
}
//function de la fin du jeu
function finJeu() {
  map.off("click", clickMap);
  btnPopup.removeEventListener("click", btnPopupContinuer);
  btnPopup.addEventListener("click", btnPopupRejouer); //changement de fonction pour le click du bouton
  popup.style.display = "block";
  var msg = document.getElementById("msg"); //affichage du msg de la fin du jeu
  msg.innerHTML =
    "<h1>Félicitations !</h1><h2>Vous avez obtenu " +
    pointsPartie +
    " points durant cette partie";
  btnPopup.textContent = "REJOUER";
  envoyerMeilleurScore();
  envoyerScoreTotal();
}
function btnPopupRejouer(e) {
  e.stopPropagation(); //on stoppe le bouilonnement des evenements
  popup.style.display = "none";
  btnPopup.textContent = "CONTINUER";
  removeLayer();
  btnPopup.removeEventListener("click", btnPopupRejouer);
  CommencerPartie(); //on recommence la partie
}
//function qui permet de calculer la distance entre 2 coordonnées gps en km
function getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
  var R = 6371; // Radius of the earth in km
  var dLat = deg2rad(lat2 - lat1); // deg2rad below
  var dLon = deg2rad(lon2 - lon1);
  var a =
    Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos(deg2rad(lat1)) *
      Math.cos(deg2rad(lat2)) *
      Math.sin(dLon / 2) *
      Math.sin(dLon / 2);
  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  var d = R * c; // Distance in km
  return d;
}

function deg2rad(deg) {
  return deg * (Math.PI / 180);
}

function envoyerMeilleurScore() {
  var url = "./recupMeilleurScore.php";
  var data = { points: pointsPartie };
  $.ajax({
    //requête web
    async: false,
    type: "POST",
    data: data,
    dataType: "text",
    url: url,
    success: function () {},
    error: function () {
      alert("PB avec l'URL");
    },
  });
}
function envoyerScoreTotal() {
  var url = "./recupScoreTotal.php";
  var data = { pointsTotal: pointsPartie };
  $.ajax({
    //requête web
    async: false,
    type: "POST",
    data: data,
    dataType: "text",
    url: url,
    success: function () {},
    error: function () {
      alert("PB avec l'URL");
    },
  });
}
