import { Component, OnInit, Inject } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Movie } from '../../../entities/Movie';
import { Http } from '@angular/http';
import { environment } from '../../../../environments/environment';
import { RefreshService } from '../../../services/RefreshService.service';
import { UserService } from '../../../services/UserService.service';

@Component({
  templateUrl: './adminpanel.component.html',
  styleUrls: ['./adminpanel.component.css']
})

export class AdminPanelComponent implements OnInit {

  users: any = null;
  id: string;
  idnum: any;

  user: any;

  roles = ['Banned', 'User', 'Admin'];

  constructor(private http: Http, private refresh: RefreshService, private userService: UserService) { }

  ngOnInit() {

    this.userService.currentUser.subscribe((user) => {
      this.user = user;
      this.refresh.notify();
    });

    this.refresh.observer.subscribe(() => {

      this.http.get(environment.context + '/users/all').subscribe((successResponse) => {

        this.users = successResponse.json();
        this.users.sort((a, b) => (a.id) - (b.id));


      }, (failResponse) => { });
    });
  }

  onBan(idnum: number) {
    const body = {
      cred: {
        username: this.user.username,
        password: this.user.password
      },
      data: idnum
    };
    this.http.post(environment.context + '/users/ban=' + idnum, body).subscribe(
      (successResponse) => {
        this.refresh.notify();
        this.ban();
      }, (failResponse) => { });
  }

  setRoleToUser(idnum: number) {
    const body = {
      cred: {
        username: this.user.username,
        password: this.user.password
      },
      data: idnum
    };
    this.http.post(environment.context + '/users/ruser=' + idnum, body).subscribe(
      (successResponse) => {
        this.refresh.notify();

      }, (failResponse) => { });
  }

  setRoleToAdmin(idnum: number) {
    const body = {
      cred: {
        username: this.user.username,
        password: this.user.password
      },
      data: idnum
    };
    this.http.post(environment.context + '/users/radmin=' + idnum, body).subscribe(
      (successResponse) => {
        this.refresh.notify();

      }, (failResponse) => { });
  }

  ban() {
    const hammer1 = document.getElementById('hammer1');
    hammer1.style.position = 'fixed';
    hammer1.style.top = '25%';
    hammer1.style.animationName = 'banhammer1';
    hammer1.style.animationDuration = '4s';
    hammer1.style.animationIterationCount = '3';
    hammer1.style.zIndex = '1';

    const hammer2 = document.getElementById('hammer2');
    hammer2.style.position = 'fixed';
    hammer2.style.top = '25%';
    hammer2.style.animationName = 'banhammer2';
    hammer2.style.animationDuration = '4s';
    hammer2.style.animationIterationCount = '3';
    hammer2.style.zIndex = '3';

    const hammer3 = document.getElementById('hammer3');
    hammer3.style.position = 'fixed';
    hammer3.style.top = '25%';
    hammer3.style.animationName = 'banhammer3';
    hammer3.style.animationDuration = '4s';
    hammer3.style.animationIterationCount = '3';
    hammer3.style.zIndex = '5';
  }

}
