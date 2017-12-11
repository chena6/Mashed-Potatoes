import { Component,  OnInit, Input } from '@angular/core';
import { Http } from '@angular/http';
import { environment } from '../../../../environments/environment';

import { UserService } from '../../../services/UserService.service';
import { RefreshService } from '../../../services/RefreshService.service';

@Component({
  selector: 'app-commentarea',
  templateUrl: './commentarea.component.html',
  styleUrls: ['./commentarea.component.css']
})
export class CommentAreaComponent implements OnInit {

  @Input()
  movie: any;
  @Input()
  userId: number;
  comments: Array<any> = null;

  user: any;

  constructor(private http: Http, private refresh: RefreshService, private userService: UserService) {}

  ngOnInit() {

    this.userService.currentUser.subscribe((user) => { this.user = user; });

    this.refresh.observer.subscribe(() => {

      if (this.movie) {
        this.http.get(environment.context + `/comments/movie=${this.movie.id}`).subscribe( (successResponse) => {

          this.comments = successResponse.json();
          this.comments.sort( (a, b) => (-a.id) - (-b.id));

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
