import { Component, OnInit, Input } from '@angular/core';
import { Router } from '@angular/router';
import { Http } from '@angular/http';
import { UserService } from '../../services/UserService.service';
import { BacklogService } from '../../services/BacklogService.service';
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
  @Input()
  backlog: any;


  constructor(private router: Router, private http: Http, private userService: UserService, private refresh: RefreshService,
    private backlogService: BacklogService) { }

  ngOnInit() {
    this.userService.currentUser.subscribe((user) => {
      this.user = user;

      this.refresh.observer.subscribe(() => {

        if (this.user) {
          this.backlogService.currentUserBacklog.subscribe((backlog) => {
            this.backlog = backlog;
          });
        }
      });
    });
  }



  delete() {
    const body = {
      cred: {
        username: this.user.username,
        password: this.user.password
      },
    };
    this.refresh.observer.subscribe(() => {
      if (this.user) {
        this.http.post(environment.context + '/users/', body).subscribe(
          (successResponse) => {
            alert(`successful deletion`);
          }, (failResponse) => { });
      }

    });
  }


}
