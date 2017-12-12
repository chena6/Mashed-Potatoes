import { Component,  OnInit, Inject } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Movie } from '../../../entities/Movie';
import { Http } from '@angular/http';
import { environment } from '../../../../environments/environment';
import { RefreshService } from '../../../services/RefreshService.service';

@Component({
  templateUrl: './adminpanel.component.html',
  styleUrls: ['./adminpanel.component.css']
})

export class AdminPanelComponent implements OnInit {

  users: any = null;
  id: string;
  idnum: any;


  constructor(private http: Http, private refresh: RefreshService) { }

  ngOnInit() {
    this.refresh.observer.subscribe(() => {
      this.http.get(environment.context + '/users/all').subscribe( (successResponse) => {

        this.users = successResponse.json();
        this.users.sort( (a, b) => (a.id) - (b.id));


      }, (failResponse) => {});
    });
  }

  onBan(idnum: number) {
    console.log(idnum);
    this.http.post(environment.context + '/users/ban=' + idnum, "").subscribe(
        (successResponse) => {
          this.refresh.notify();
          //this.users = successResponse.json();
    },  (failResponse) => {});
  }

  setRoleToUser(idnum: number) {
    this.http.post(environment.context + '/users/ruser=' + idnum, "").subscribe(
        (successResponse) => {
          this.refresh.notify();
          //this.users = successResponse.json();
    },  (failResponse) => {});
  }

  setRoleToAdmin(idnum: number) {
    this.http.post(environment.context + '/users/radmin=' + idnum, "").subscribe(
        (successResponse) => {
          this.refresh.notify();
          //this.users = successResponse.json();
    },  (failResponse) => {});
  }

  

  
}
