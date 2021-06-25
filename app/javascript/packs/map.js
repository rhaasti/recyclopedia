import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

// const fitMapToMarkers = (map, markers) => {
//   const bounds = new mapboxgl.LngLatBounds();
//   markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
//   map.fitBounds(bounds, { padding: 60, maxZoom: 15, duration: 0 });
// };

const initMapbox = () => {
  const mapElement = document.getElementById('map');
  const user_coordinates = JSON.parse(mapElement.dataset.coordinates);
  const markers = JSON.parse(mapElement.dataset.markers);

  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10',
      zoom: 10,
      center: [user_coordinates.lng, user_coordinates.lat]
    });

    // map.setCenter([ user_coordinates.lng + 20, user_coordinates.lat + 20 ]);

    const element = document.createElement('div');
    element.className = 'user-marker';
    element.style.backgroundImage = `url('${user_coordinates.image_url}')`;
    element.style.backgroundSize = 'contain';
    element.style.width = '20px';
    element.style.height = '20px';
    
    new mapboxgl.Marker(element)
      .setLngLat( [ user_coordinates.lng, user_coordinates.lat ] )
      .addTo(map);

    markers.forEach((marker) => {

      var popup = new mapboxgl.Popup( { offset: 25 } )
                  .setHTML(marker.info_window);
      
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(map);
    });

    // fitMapToMarkers(map, markers);
  }
};

export { initMapbox };