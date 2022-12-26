window.addEventListener("load", init);
var mark1;
var mark2;
var mark3;
var points = 0;
var nomVille;
var map;
var base;
var popup;
var monMarqueur;
var bool = true;
var html;
var popup;
var msg;
var monPopup;
var ville;
var lon, lat;
var tabCoord = new Array();
var random;
var tailleVille;
var btnPopup;
var pointsPartie;
var MancheJouer;
var BtnJouer;
var BtnJouerSansChrono;
var BoolChrono;
function init() {
  msg = document.getElementById("msg");
  popup = document.getElementById("popup");
  nomVille = document.getElementById("nomVille");
  btnPopup = document.getElementById("btn");
  BtnJouer = document.getElementById("lancerAvecChrono");
  BtnJouerSansChrono = document.getElementById("lancerSansChrono");
  BtnJouer.addEventListener("click", chargerMap);
  BtnJouerSansChrono.addEventListener("click", chargerMap);
}
function chargerMap(e) {
  if (e.target.id == "lancerSansChrono") BoolChrono = false;
  else BoolChrono = true;
  e.stopPropagation();
  map = L.map("map", {
    center: [46.9343, 1.9],
    zoom: 5.4,
    zoomControl: false,
  });
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
  CommencerPartie();
}

function CommencerPartie() {
  pointsPartie = 0;
  recupVilles();
  for (var i = 0; i < ville.length; i++) {
    recupCoordVille(i);
  }
  btnPopup.addEventListener("click", btnPopupContinuer);
  document.getElementById("points").textContent = 0;
  montrerbtn();
  jouer();
}
function montrerbtn() {
  var recommencer = document.getElementById("recommencer");
  recommencer.style.display = "block";
  recommencer.addEventListener("click", btnPopupRejouer);
}
function pausePartie(e) {
  e.stopPropagation();
}
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
      tailleVille = ville.length;
    },
    error: function () {
      alert("PB avec l'URL");
    },
  });
}
function recupCoordVille(i) {
  url =
    "https://nominatim.openstreetmap.org/search?q=" +
    ville[i].nom +
    "&format=json&polygon_geojson=1&addressdetails=1";
  $.ajax({
    //requête web
    async: false, //défaut
    type: "GET",
    dataType: "json",
    url: url,
    success: function (retour) {
      let ville = {
        lon: retour[0].lon,
        lat: retour[0].lat,
      };
      tabCoord[i] = ville;
    },
    error: function () {
      alert("PB avec l'URL");
    },
  });
}
function jouer() {
  if (ville.length == 0) finJeu();
  else {
    coup();
  }
}
function finJeu() {
  map.off("click", f);
  popup.style.display = "block";
  msg.innerHTML =
    "<h1>Félicitations !</h1><h2>Vous avez obtenu " +
    pointsPartie +
    " points durant cette partie";
  btnPopup.removeEventListener("click", btnPopupContinuer, true);
  btnPopup.addEventListener("click", btnPopupRejouer);
  btnPopup.textContent = "REJOUER";
}
function btnPopupRejouer(e) {
  e.stopPropagation();
  popup.style.display = "none";
  btnPopup.textContent = "CONTINUER";
  removeLayer();
  btnPopup.removeEventListener("click", btnPopupRejouer, true);
  CommencerPartie();
}
function coup() {
  document.getElementById("manche").textContent =
    tailleVille - ville.length + 1 + "/" + tailleVille;
  MancheJouer = 0;
  random = Math.floor(Math.random() * ville.length);
  nomVille.textContent = ville[random].nom;
  nomVille.style.display = "block !important";
  if (BoolChrono) jauge();
  map.on("click", f);
}
function jauge() {
  const progressbar = document.querySelector("progress");
  progressbar.style.display = "block";
  progressbar.style.width = "100%";
  const changeProgress = (progress) => {
    if (MancheJouer == 0) progressbar.style.width = `${progress}%`;
  };
  // for (var i = 0; i < 100; i++) {
  //   if (MancheJouer == 0) {
  //     btnPopupContinuer();
  //     return;
  //   } else setTimeout(() => changeProgress(100 - i), i * 10);
  // }
  /* change progress after 1 second (only for showcase) */
  setTimeout(() => changeProgress(90), 1000);
  setTimeout(() => changeProgress(80), 2000);
  setTimeout(() => changeProgress(70), 3000);
  setTimeout(() => changeProgress(60), 4000);
  setTimeout(() => changeProgress(50), 5000);
  setTimeout(() => changeProgress(40), 6000);
  setTimeout(() => changeProgress(30), 7000);
  setTimeout(() => changeProgress(20), 8000);
  setTimeout(() => changeProgress(10), 9000);
  setTimeout(() => changeProgress(0), 10000);
  setTimeout(function () {
    if (MancheJouer == 0) btnPopupContinuer();
  }, 10000);
}

function attribuerPoints(Distance) {
  var tmp = points;
  if (Distance > 400) points += 0;
  else if (Distance > 300) points += 50;
  else if (Distance > 200) points += 100;
  else if (Distance > 100) points += 200;
  else if (Distance > 50) points += 400;
  else if (Distance > 25) points += 800;
  else if (Distance > 10) points += 1600;
  else if (Distance > 5) points += 3200;
  else if (Distance >= 0) points += 6400;
  return points - tmp;
}
function f(e) {
  map.off("click", f);
  MancheJouer = 1;
  mark1 = L.marker([e.latlng.lat, e.latlng.lng], {
    draggable: false,
  }).addTo(map);
  var dist = getDistanceFromLatLonInKm(
    e.latlng.lat,
    e.latlng.lng,
    tabCoord[random].lat,
    tabCoord[random].lon
  );
  dist *= 1000;
  var pointsManche = attribuerPoints(dist / 1000);
  pointsPartie += pointsManche;
  setTimeout(function () {
    mark2 = L.circle([e.latlng.lat, e.latlng.lng], dist, {
      color: "red",
      weight: 1,
      fillColor: "blue",
    }).addTo(map);
    mark3 = L.marker([tabCoord[random].lat, tabCoord[random].lon], {
      draggable: false,
    }).addTo(map);
  }, 500);
  setTimeout(function () {
    popup.style.display = "block";
    msg.innerHTML =
      "<h3 class='nb'>" +
      (tailleVille - ville.length + 1) +
      "/" +
      tailleVille +
      "</h3><h2 class='ville'>" +
      ville[random].nom +
      "</h2><img width='50%'class='img' src=" +
      ville[random].img +
      "><h2 class='distance'>Distance: " +
      Math.floor(dist / 1000) +
      "km</h2><h2 class='points'>Points: " +
      pointsManche +
      "</h2><h2 class='time'></h2>";
    btnPopup.textContent = "CONTINUER";
    document.getElementById("points").textContent = pointsPartie;
  }, 2000);
}
function btnPopupContinuer(e) {
  e.stopPropagation();
  console.log("continuer");
  removeLayer();
  ville.splice(random, 1);
  tabCoord.splice(random, 1);
  popup.style.display = "none";
  jouer();
}
function removeLayer() {
  if (mark1 != null) map.removeLayer(mark1);
  if (mark2 != null) map.removeLayer(mark2);
  if (mark3 != null) map.removeLayer(mark3);
}
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
