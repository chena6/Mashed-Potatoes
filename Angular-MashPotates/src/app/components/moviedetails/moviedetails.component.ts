import { Component,  OnInit, Inject } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Movie } from '../../entities/Movie';
import { Http } from '@angular/http';
import { Observable } from 'rxjs/Observable';

@Component({
  templateUrl: './moviedetails.component.html',
  styleUrls: ['./moviedetails.component.css']
})
export class MovieDetailsComponent implements OnInit {

  movie: any = null;
  id: string;

  constructor(@Inject(Http) public http: Http, private route: ActivatedRoute) {
    this.route.params.subscribe( params => this.id = params.id );
  }

  ngOnInit() {

    const observable = this.http.get(`http://localhost:8080/mashed-potatoes/movies/${this.id}`);
    observable.subscribe( (successResponse) => {

      this.movie = successResponse.json();

    }, (failResponse) => {

      alert('failed');

    });

  }
}
