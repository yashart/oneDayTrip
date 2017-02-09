import QtQuick 2.7
import QtQuick.Controls 2.0
import QtPositioning 5.5
import QtLocation 5.6
import QtQuick.Layouts 1.3



Item {
    Plugin {
        id: mapboxPlugin
        name: "mapbox"
        PluginParameter { name: "mapbox.access_token"; value: "pk.eyJ1IjoicHJvbWlzdHJpbyIsImEiOiJjaW1wNmIzaHQwMDJ5d2FtNGNhb28zZTRsIn0.nYE56atkirjFdB5oEkpYVA" }
        PluginParameter {id: map_id; name: "mapbox.map_id"; value: "promistrio.1i2blkkj" }
    }

    Map {
        plugin: mapboxPlugin
        id: map

        zoomLevel: 15
        anchors.fill: parent

        RouteModel {
            id: routeModel
            plugin: mapboxPlugin
            query: RouteQuery {
                id: routeQuery
            }
        }

        MapItemView {
            model: routeModel
            delegate: routeDelegate
        }

        Component {
            id: routeDelegate

            MapRoute {
                id: route
                route: routeData
                line.color: "red"
                line.width: 5
                smooth: true
                opacity: 0.8
            }
        }

        ListModel {
            id: travelPoints
        }

        MapItemView {
            model: travelPoints
            delegate: MapQuickItem {
                coordinate {
                        latitude: lat
                        longitude: lon
                    }
                sourceItem: Image {
                    source: "img/start.png"
                    z: 1
                }
            }
        }
    }
    function make_trip(userLatitude, userLongitude){
        routeQuery.clearWaypoints();
        map.center = QtPositioning.coordinate(userLatitude, userLongitude);

        routeQuery.addWaypoint(QtPositioning.coordinate(userLatitude, userLongitude));
        routeQuery.addWaypoint(QtPositioning.coordinate(userLatitude + 0.01, userLongitude));
        routeQuery.addWaypoint(QtPositioning.coordinate(userLatitude + 0.01, userLongitude + 0.01));
        routeQuery.addWaypoint(QtPositioning.coordinate(userLatitude, userLongitude + 0.01));
        routeQuery.addWaypoint(QtPositioning.coordinate(userLatitude, userLongitude));

        routeQuery.travelModes = RouteQuery.PedestrianTravel;
        routeQuery.routeOptimizations = RouteQuery.MostScenicRoute;
        routeModel.update();

        travelPoints.clear();
        travelPoints.append({"lat": userLatitude, "lon": userLongitude})
        travelPoints.append({"lat": userLatitude + 0.01, "lon": userLongitude})
        travelPoints.append({"lat": userLatitude + 0.01, "lon": userLongitude + 0.01})
        travelPoints.append({"lat": userLatitude, "lon": userLongitude + 0.01})


    }
}
