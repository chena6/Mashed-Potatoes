import { Component,  OnInit, Inject } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Movie } from '../../../entities/Movie';
import { Http } from '@angular/http';
import { environment } from '../../../../environments/environment';

@Component({
  templateUrl: './adminpanel.component.html',
  styleUrls: ['./adminpanel.component.css']
})
export class AdminPanelComponent implements OnInit {

  users: any = null;
  id: string;

  constructor(private http: Http) { }

  ngOnInit() {

    this.http.get(environment.context + '/users/all').subscribe( (successResponse) => {

      this.users = successResponse.json();
      this.users.sort( (a, b) => (a.id) - (b.id));

    }, (failResponse) => {});

  }
}
