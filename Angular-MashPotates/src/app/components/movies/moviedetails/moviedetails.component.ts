import { Component, OnInit, Inject, Input } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Movie } from '../../../entities/Movie';
import { Http } from '@angular/http';
import { environment } from '../../../../environments/environment';

import { UserService } from '../../../services/UserService.service';
import { RefreshService } from '../../../services/RefreshService.service';
import { WatchedService } from '../../../services/WatchedService.service';
import { BacklogService } from '../../../services/BacklogService.service';

@Component({
  templateUrl: './moviedetails.component.html',
  styleUrls: ['./moviedetails.component.css']
})
export class MovieDetailsComponent implements OnInit {

  movie: any = null;
  id: string;
  user: any = null;
  watched: any = null;
  backlog: any = null;
  backlogstatus = true;
  watchedstatus = false;

  constructor(private http: Http, private route: ActivatedRoute, private userService: UserService, private refresh: RefreshService,
    private watchedService: WatchedService, private backlogService: BacklogService) {
    this.route.params.subscribe(params => this.id = params.id);
  }

  ngOnInit() {
    this.userService.currentUser.subscribe((user) => { this.user = user; });
    this.refresh.observer.subscribe(() => {
      console.log(this.user);
      this.http.get(environment.context + `/movies/${this.id}`)
        .subscribe((successResponse) => {
          this.movie = successResponse.json();

          if (this.movie.poster === 'N/A') {
            this.movie.poster = 'http://movieseek.info/assets/images/imdbnoimage.jpg';
          }

        }, (failResponse) => { });
    });
  }

  Watched(movieid) {
    this.userService.currentUser.subscribe((user) => { this.user = user; });

    const body = {
      cred: {
        username: this.user.username,
        password: this.user.password
      },
    };

    this.refresh.observer.subscribe(() => {
      if (this.user) {
        this.http.post(environment.context + '/users/watched=' + this.user.id + '-' + movieid, body).subscribe(
          (successResponse) => {
            this.http.get(environment.context + `/users/watched/${this.user.id}`).subscribe((successResponse2) => {

              this.watched = successResponse2.json();
              this.watchedService.setMovies(this.watched);
            }, (failResponse) => { });
          }, (failResponse) => { });
      }
    });
  }

  Backlog(movieid) {
    this.userService.currentUser.subscribe((user) => { this.user = user; });

    const body = {
      cred: {
        username: this.user.username,
        password: this.user.password
      },
    };

    this.refresh.observer.subscribe(() => {
      if (this.user) {
        this.http.post(environment.context + '/users/backlog=' + this.user.id + '-' + movieid, body).subscribe(
          (successResponse) => {
            this.http.get(environment.context + `/users/backlog/${this.user.id}`).subscribe((successResponse2) => {

              this.backlog = successResponse2.json();
              this.backlogService.setMovies(this.backlog);
              this.backlogstatus = this.logContains(this.backlog, this.movie);
              if (this.backlog.includes(movieid)) {
                (<HTMLInputElement>document.getElementById('backlogbutton')).disabled = true;
              }

            }, (failResponse) => { });
          }, (failResponse) => { });
      }
    });
  }

  logContains(log: Array<any>, movie) {

    for (let i = 0; i < log.length; i++) {
      if (log[i].movie === movie) {
        return true;
      }
    }
    return false;
  }
}

