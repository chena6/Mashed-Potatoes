import { Component,  OnInit, Input } from '@angular/core';
import { Http } from '@angular/http';
import { environment } from '../../../../environments/environment';
import { RefreshService } from '../../../services/RefreshService.service';

@Component({
  selector: 'app-reviewarea',
  templateUrl: './reviewarea.component.html',
  styleUrls: ['./reviewarea.component.css']
})
export class ReviewAreaComponent implements OnInit {

  @Input()
  score: number;
  @Input()
  movieId: string;
  @Input()
  userId: number;
  reviews: Array<any> = null;

  constructor(private http: Http, private refresh: RefreshService) {}

  ngOnInit() {

    this.refresh.observer.subscribe(() => {

      if (this.movieId) {
        this.http.get(environment.context + `/reviews/movie=${this.movieId}`)
          .subscribe( (successResponse) => {

        this.reviews = successResponse.json();

        }, (failResponse) => { });
      }

      if (this.userId) {
        this.http.get(environment.context + `/reviews/user=${this.userId}`)
          .subscribe( (successResponse) => {

        this.reviews = successResponse.json();

        }, (failResponse) => { });
      }

    });

  }

}
