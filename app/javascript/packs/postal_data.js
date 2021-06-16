import { initMapbox } from './map';

const urlParams = new URLSearchParams(window.location.search);
const zipcode = urlParams.get('zipcode');
const map = document.querySelector('#map');

if (zipcode && map ) {
  fetch(`https://api.earth911.com/earth911.getPostalData?api_key=5b7412cae7282842&country=us&postal_code=${zipcode}`)
  .then(response => response.json())
  .then((data) => { 
    if (data.code == 0) {
      window.location.href = "/";
    } else {
    const lat  = data["result"]["latitude"];
    const long = data["result"]["longitude"];
    const userCoords = {
      lat: lat,
      lng: long,
      image_url: 'https://res.cloudinary.com/dg5c592li/image/upload/v1623527941/home-icon.png'
    }
    const materialIds = document.querySelector('.title-box').dataset.materialIds;
    const programUrl  = `https://api.earth911.com/earth911.searchPrograms?api_key=5b7412cae7282842&latitude=${lat}&longitude=${long}&material_ids=${materialIds}`

    document.getElementById('map').dataset.coordinates  = JSON.stringify(userCoords);
    getPrograms(programUrl);
    };
  });
}

async function getPrograms(programUrl) {
  let response = await fetch(programUrl);
  let parsedResponse = await response.json();
  const markers = [];

  for (const program of parsedResponse['result']) {
    let marker = await getProgram(program);
    markers.push(marker);
  }

  document.getElementById('map').dataset.markers = JSON.stringify(markers);
  document.getElementById('load-bar').remove()
  initMapbox();
}

async function getProgram(program) {
  let marker = '';

  let response = await fetch(`https://api.earth911.com/earth911.getProgramDetails?api_key=5b7412cae7282842&program_id=${program["program_id"]}`)
  if (response.ok) {
    let programData = await response.json();

    marker = {
      "lat": programData['result'][program["program_id"]]['latitude'],
      "lng": programData['result'][program["program_id"]]['longitude'],
      "info_window": infoWindow(programData["result"][program["program_id"]])
    }
  }

  return marker;
}

const infoWindow = (programInfo) => {
    return(`<div class="info-window">
    <p>${programInfo['description']}</p>
    <ul>
     ${
       programInfo['hours'].length > 0 ? `<li> <strong>Hours:</strong>${programInfo['hours']}</li>` :
        `<li> <strong>Hours:</strong> Didn't specify</li>`
      }
      ${
        programInfo['phone'].length > 0 ? `<strong>Phone:</strong>${programInfo['phone']}</li>` :
        `<li> <strong>Phone:</strong> Didn't specify</li>`
      }
      ${
        programInfo['curbside'] ? `<li> <strong>Curbside:</strong> Yes </li>` :
        `<li> <strong>Curbside</strong> No </li>`
      }
      ${
        programInfo['notes'].length > 0 ? `<li> <strong>Notes:</strong>${programInfo['notes']}</li>` :
        `<li> <strong>Notes:</strong> None</li>`
      }
    </ul>
  </div>
  `)
}
