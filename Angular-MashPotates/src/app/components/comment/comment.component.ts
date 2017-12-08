import { Component,  OnInit, Input } from '@angular/core';
import { Http } from '@angular/http';
import { environment } from '../../../environments/environment';

@Component({
  selector: 'app-comment',
  templateUrl: './comment.component.html',
  styleUrls: ['./comment.component.css']
})
export class CommentComponent implements OnInit {

  @Input()
  comment: any;
  user: any = null;

  constructor(private http: Http) {}

  ngOnInit() {

    this.http.get(environment.context + `/users/${this.comment.user}`)
      .subscribe( (successResponse) => {

    this.user = successResponse.json();

  }, (failResponse) => { });

  }

}
