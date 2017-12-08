import { Component,  OnInit, Inject } from '@angular/core';
import { Http } from '@angular/http';
import {Observable} from 'rxjs/Observable';

@Component({
  templateUrl: './landing.component.html',
  styleUrls: ['./landing.component.css']
})
export class LandingPageComponent implements OnInit {

  movies: Array<any>;

  constructor(@Inject(Http) public http: Http) {

  }

  ngOnInit() {

    //this.movies = JSON.parse(`[{"id":"tt3896240","title":"Shamsheer","year":"1967","rating":null,"runtime":"N/A","director":{"id":33,"firstname":"Babubhai","lastname":"Mistri"},"plot":"N/A","poster":"N/A","genres":[{"id":12,"genre":"ACTION"}],"actors":[{"id":178,"firstname":"Jeevan","lastname":" "},{"id":177,"firstname":"Aruna","lastname":"Irani"},{"id":176,"firstname":"Helen","lastname":" "},{"id":179,"firstname":"Prithviraj","lastname":"Kapoor"}]},{"id":"tt3896296","title":"Episode dated 27 August 1999","year":"1999","rating":null,"runtime":"N/A","director":{"id":2,"firstname":"N/A","lastname":" "},"plot":"N/A","poster":"N/A","genres":[{"id":8,"genre":"TALK-SHOW"}],"actors":[{"id":128,"firstname":"Flavia","lastname":"Palmiero"},{"id":127,"firstname":"Osvaldo","lastname":"Laport"},{"id":129,"firstname":"Viviana","lastname":"SÃ¡ez"},{"id":80,"firstname":"Jorge","lastname":"Guinzburg"}]},{"id":"tt3896246","title":"Safety in Paradise","year":"2014","rating":null,"runtime":"N/A","director":{"id":2,"firstname":"N/A","lastname":" "},"plot":"Models from the Sports Illustrated swimsuit issue and residents of Cook Islands demonstrate airline safety, without actually being on an airplane.","poster":"N/A","genres":[{"id":3,"genre":"SHORT"}],"actors":[{"id":172,"firstname":"Jessica","lastname":"Gomes"},{"id":174,"firstname":"Hannah","lastname":"Davis"},{"id":171,"firstname":"Christie","lastname":"Brinkley"},{"id":173,"firstname":"Christine","lastname":"Teigen"}]},{"id":"tt3896364","title":"Weird Al Yankovic/Adam Korson","year":"2014","rating":null,"runtime":"N/A","director":{"id":16,"firstname":"Shannon","lastname":"Walden,"},"plot":"N/A","poster":"N/A","genres":[{"id":8,"genre":"TALK-SHOW"}],"actors":[{"id":37,"firstname":"Porscha","lastname":"Coleman"},{"id":39,"firstname":"Jonathan","lastname":"Hyla"},{"id":38,"firstname":"AJ","lastname":"Gibson"},{"id":36,"firstname":"Kristen","lastname":"Brockman"}]},{"id":"tt3896258","title":"The Spider-Man Trilogy","year":"2014","rating":null,"runtime":"N/A","director":{"id":2,"firstname":"N/A","lastname":" "},"plot":"N/A","poster":"N/A","genres":[{"id":7,"genre":"COMEDY"}],"actors":[{"id":3,"firstname":"N/A","lastname":" "}]}]`);

    const observable = this.http.get('http://localhost:8080/mashed-potatoes/movies');
    observable.subscribe( (successResponse) => {

      this.movies = successResponse.json();

    }, (failResponse) => {

      alert('failed');

    });

  }
}
