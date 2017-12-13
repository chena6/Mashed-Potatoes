import { Component, OnInit, Input } from '@angular/core';
import { Router } from '@angular/router';
import { Http } from '@angular/http';
import { UserService } from '../../services/UserService.service';
import { RefreshService } from '../../services/RefreshService.service';
import { environment } from '../../../environments/environment';

@Component({
  selector: 'app-backlog',
  templateUrl: './backlog.component.html',
  styleUrls: ['./backlog.component.css']
})
export class BacklogComponent implements OnInit {

  @Input()
  user: any;

  movies: any;


  constructor(private router: Router, private http: Http, private userService: UserService, private refresh: RefreshService) { }

  ngOnInit() {
    this.userService.currentUser.subscribe((user) => {
      this.user = user;

      this.refresh.observer.subscribe(() => {

        if (this.user) {
          this.http.get(environment.context + `/users/backlog/${this.user.id}`).subscribe((successResponse) => {

            this.movies = successResponse.json();

          }, (failResponse) => { });
        }
      });
    });
  }

}
