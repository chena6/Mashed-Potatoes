import { Component,  OnInit, Input } from '@angular/core';
import { Http } from '@angular/http';
import { environment } from '../../../environments/environment';

@Component({
  selector: 'app-commentarea',
  templateUrl: './commentarea.component.html',
  styleUrls: ['./commentarea.component.css']
})
export class CommentAreaComponent implements OnInit {

  @Input()
  id: string;
  comments: Array<any> = null;

  constructor(private http: Http) {}

  ngOnInit() {

    this.http.get(environment.context + `/comments/${this.id}`)
      .subscribe( (successResponse) => {

    this.comments = successResponse.json();

  }, (failResponse) => { });

  }

}
