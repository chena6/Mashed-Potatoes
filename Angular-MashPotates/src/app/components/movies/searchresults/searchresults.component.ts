import { Component,  OnInit } from '@angular/core';
import { SearchService } from '../../../services/SearchService.service';

@Component({
  templateUrl: './searchresults.component.html',
  styleUrls: ['./searchresults.component.css']
})
export class SearchResultsComponent implements OnInit {

  searchResults: Array<any>;

  constructor(private search: SearchService) {}

  ngOnInit() {
    this.search.searchResults.subscribe( (results) => {this.searchResults = results; });
  }
}
