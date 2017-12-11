import { Component,  OnInit, Inject } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Movie } from '../../../entities/Movie';
import { Http } from '@angular/http';
import { environment } from '../../../../environments/environment';

@Component({
  templateUrl: './userdetails.component.html',
  styleUrls: ['./userdetails.component.css']
})
export class UserDetailsComponent implements OnInit {

  user: any = null;
  id: string;

  constructor(private http: Http, private route: ActivatedRoute) {
    this.route.params.subscribe( params => this.id = params.id );
  }

  ngOnInit() {

    this.http.get(environment.context + `/users/${this.id}`)
      .subscribe( (successResponse) => {

      this.user = successResponse.json();

    }, (failResponse) => {});

  }
}
