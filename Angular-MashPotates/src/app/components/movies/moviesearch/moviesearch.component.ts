import { Component, Input, Output, EventEmitter } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { Router } from '@angular/router';
import { Http } from '@angular/http';

@Component({
  selector: 'app-moviesearch',
  templateUrl: './moviesearch.component.html',
  styleUrls: ['./moviesearch.component.css']
})
export class MovieSearchComponent {

  searchQuery: string;
  @Output()
  searchEvent = new EventEmitter<any>();

  constructor(private router: Router, private http: Http) {}

  onSubmit() {

    this.http.post(environment.context + `/movies/search`, this.searchQuery)
    .subscribe( (successResponse) => {

    this.searchEvent.emit(successResponse.json());
    this.router.navigate(['/search']);

    }, (failResponse) => { });

  }
}
