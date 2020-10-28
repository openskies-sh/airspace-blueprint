/**
* Name: renoutm
* Based on the internal empty template. 
* Author: Hrishikesh Ballal
* Tags: 
*/

model bernutm

/* Insert your model definition here */

global {
    file shape_file_buildings <- file("../includes/bern-buildings.shp");
    file shape_file_roads <- file("../includes/bern-roads.shp");
    file shape_file_bounds <- file("../includes/bern-3km-extent.shp");
    geometry shape <- envelope(shape_file_bounds);
    // float step <- 1 #mn; // override the default step of 1s (https://gama-platform.github.io/wiki/ManipulateDates)
    date starting_date <- #now; // date("2020-09-01-00-00-00");
    
    int min_work_start <- 6;
    int max_work_start <- 8;
    int min_work_end <- 16; 
    int max_work_end <- 20; 
    int nb_drones <- 1;
    float min_speed <- 10.0 #km / #h;
    float max_speed <- 25.0 #km / #h; 
    graph road_graph;    
    
    // Paint the buildings
    init {
    create building from: shape_file_buildings with: [type::string(read ("newlanduse"))] {
        if type="industrial1" {
        color <- #blue;
        }
        if type="residential1" {
        color <- #purple;
        }
    }
    create road from: shape_file_roads ;
    road_graph <- as_edge_graph(road);
        
    list<building> residential_buildings <- building where (each.type="residential1");
    list<building> industrial_buildings <- building  where (each.type="industrial1") ;
    create drones number: nb_drones {
        speed <- rnd(min_speed, max_speed);
        delivery_start <- one_of(industrial_buildings) ;
        delivery_end <- one_of(residential_buildings) ;
        write delivery_end;
        objective <- "resting";
        location <- any_location_in (delivery_start); 
    }
    }
}

species building {
    string type; 
    rgb color <- #gray;
    
    aspect base {
    draw shape color: color ;
    }
}

species road  {
    rgb color <- #black ;
    int elementHeight;
    aspect base {
    draw shape color: color depth: elementHeight;
    }
}

species drones skills:[moving] {
    rgb color <- #yellow ;
    building delivery_end <- nil ;
    building delivery_start <- nil ;
    
	string objective ; 
    point the_target <- nil ;
        
          
    reflex time_to_deliver when: objective = "resting"{
    objective <- "working" ;
    the_target <- any_location_in (one_of(delivery_start));
    }
        
    reflex time_to_go_home when: objective = "working"{
    objective <- "resting" ;
    the_target <- any_location_in (one_of(delivery_end)); 
    } 
     
    reflex move when: the_target != nil {
    do goto target: the_target on: road_graph ; 
    if the_target = location {    	
    	 the_target <- nil ;        
    }
    }
    
    aspect base {
    draw circle(10) color: color border: #black;
    }
}


experiment air_traffic type: gui {
    parameter "Shapefile for the buildings:" var: shape_file_buildings category: "GIS" ;
    parameter "Shapefile for the roads:" var: shape_file_roads category: "GIS" ;
    parameter "Shapefile for the bounds:" var: shape_file_bounds category: "GIS" ;  
    parameter "Number of drone agents" var: nb_drones category: "Drones" ;
    parameter "minimal speed" var: min_speed category: "Drones" min: 15 #km/#h ;
    parameter "maximal speed" var: max_speed category: "Drones" max: 30 #km/#h;
    
    output {
    display city_display type: opengl {
        species building aspect: base ;
        species road aspect: base ;
        species drones aspect: base ;
    }
     display chart_display refresh: every(5#cycles) { 
        chart "Drones" type: histogram  style: exploded size: {1, 0.5} position: {0, 0}{
        data "Working" value: drones count (each.objective="working") color: #magenta;
        data "Resting" value: drones count (each.objective="resting") color: #blue;
        }
    }
    }
}