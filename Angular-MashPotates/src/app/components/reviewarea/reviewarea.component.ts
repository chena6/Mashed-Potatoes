import { Component,  OnInit, Input } from '@angular/core';
import { Http } from '@angular/http';
import { environment } from '../../../environments/environment';

@Component({
  selector: 'app-reviewarea',
  templateUrl: './reviewarea.component.html',
  styleUrls: ['./reviewarea.component.css']
})
export class ReviewAreaComponent implements OnInit {

  @Input()
  score: number;
  @Input()
  id: string;
  reviews: Array<any> = null;

  constructor(private http: Http) {}

  ngOnInit() {

    this.http.get(environment.context + `/reviews/${this.id}`)
      .subscribe( (successResponse) => {

    this.reviews = successResponse.json();

  }, (failResponse) => { });

  }

}
