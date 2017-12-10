import { Component,  OnInit, Inject } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Movie } from '../../../entities/Movie';
import { Http } from '@angular/http';
import { environment } from '../../../../environments/environment';

import { UserService } from '../../../services/UserService.service';

@Component({
  templateUrl: './moviedetails.component.html',
  styleUrls: ['./moviedetails.component.css']
})
export class MovieDetailsComponent implements OnInit {

  movie: any = null;
  id: string;
  user: any = null;

  constructor(private http: Http, private route: ActivatedRoute, private userService: UserService) {
    this.route.params.subscribe( params => this.id = params.id );
  }

  ngOnInit() {

    this.userService.currentUser.subscribe((user) => {this.user = user; console.log(user)});
    this.http.get(environment.context + `/movies/${this.id}`)
      .subscribe( (successResponse) => {

      this.movie = successResponse.json();

      if (this.movie.poster === 'N/A') {
        this.movie.poster = 'http://movieseek.info/assets/images/imdbnoimage.jpg';
      }

    }, (failResponse) => {});

  }
}
