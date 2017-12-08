import { Component,  OnInit, Inject } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Movie } from '../../entities/Movie';
import { Http } from '@angular/http';
import { environment } from '../../../environments/environment';

@Component({
  templateUrl: './moviedetails.component.html',
  styleUrls: ['./moviedetails.component.css']
})
export class MovieDetailsComponent implements OnInit {

  movie: any = null;
  id: string;

  constructor(private http: Http, private route: ActivatedRoute) {
    this.route.params.subscribe( params => this.id = params.id );
  }

  ngOnInit() {

    this.http.get(environment.context + `/movies/${this.id}`)
      .subscribe( (successResponse) => {

      this.movie = successResponse.json();

      if (this.movie.poster === 'N/A') {
        this.movie.poster = 'http://movieseek.info/assets/images/imdbnoimage.jpg';
      }

    }, (failResponse) => {});

  }
}
