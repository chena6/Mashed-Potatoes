import { Component, OnInit, Input } from '@angular/core';
import { Router } from '@angular/router';
import { Http } from '@angular/http';
import { UserService } from '../../services/UserService.service';
import { RefreshService } from '../../services/RefreshService.service';
import { environment } from '../../../environments/environment';


@Component({
  selector: 'app-watched',
  templateUrl: './watched.component.html',
  styleUrls: ['./watched.component.css']
})
export class WatchedComponent implements OnInit {

  userId: number;
  @Input()
  user: any;
  movies: any;

  constructor(private router: Router, private http: Http, private userService: UserService, private refresh: RefreshService) { }

  ngOnInit() {

    this.refresh.observer.subscribe(() => {
      if (this.user) {
        this.http.get(environment.context + `/users/watched/${this.user.id}`).subscribe((successResponse) => {

          this.movies = successResponse.json();

        }, (failResponse) => { });
      }
    });
  }

}
