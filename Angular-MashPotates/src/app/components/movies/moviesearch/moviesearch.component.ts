import { Component, Input, Output, EventEmitter } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { Router } from '@angular/router';
import { Http } from '@angular/http';
import { SearchService } from '../../../services/SearchService.service';

@Component({
  selector: 'app-moviesearch',
  templateUrl: './moviesearch.component.html',
  styleUrls: ['./moviesearch.component.css']
})
export class MovieSearchComponent {

  searchQuery: string;

  constructor(private router: Router, private http: Http, private search: SearchService) {}

  onSubmit() {

    this.http.post(environment.context + `/movies/search`, this.searchQuery)
    .subscribe( (successResponse) => {

    this.search.setResults(successResponse.json());
    this.router.navigate(['/search']);

    }, (failResponse) => { });
  }
}
