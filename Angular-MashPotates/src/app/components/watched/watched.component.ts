import { Component, OnInit, Input } from '@angular/core';
import { Router } from '@angular/router';
import { Http } from '@angular/http';
import { UserService } from '../../services/UserService.service';
import { RefreshService } from '../../services/RefreshService.service';
import { WatchedService } from '../../services/WatchedService.service';
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
  @Input()
  watched: any;

  constructor(private router: Router, private http: Http, private userService: UserService, private refresh: RefreshService,
  private watchedService: WatchedService) { }

  ngOnInit() {
    this.userService.currentUser.subscribe((user) => {
      this.user = user;

      this.refresh.observer.subscribe(() => {

        if (this.user) {
          this.watchedService.currentUserWatched.subscribe((watched) => {
            this.watched = watched;
          });
        }
      });
    });
  }
}

