import { Component,  OnInit, Input } from '@angular/core';
import { Http } from '@angular/http';
import { environment } from '../../../../environments/environment';
import { RefreshService } from '../../../services/RefreshService.service';

@Component({
  selector: 'app-commentarea',
  templateUrl: './commentarea.component.html',
  styleUrls: ['./commentarea.component.css']
})
export class CommentAreaComponent implements OnInit {

  @Input()
  movieId: string;
  @Input()
  userId: number;
  comments: Array<any> = null;

  constructor(private http: Http, private refresh: RefreshService) {}

  ngOnInit() {

    this.refresh.observer.subscribe(() => {

      if (this.movieId) {
        this.http.get(environment.context + `/comments/movie=${this.movieId}`)
          .subscribe( (successResponse) => {

        this.comments = successResponse.json();

        }, (failResponse) => { });
      }

      if (this.userId) {
        this.http.get(environment.context + `/comments/user=${this.userId}`)
          .subscribe( (successResponse) => {

        this.comments = successResponse.json();

        }, (failResponse) => { });
      }
    });

  }

}
