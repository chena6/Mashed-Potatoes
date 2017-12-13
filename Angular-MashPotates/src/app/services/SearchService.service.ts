import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs/BehaviorSubject';

@Injectable()
export class SearchService {

    private searchSubject = new BehaviorSubject<Array<any>>(null);
    searchResults = this.searchSubject.asObservable();

    constructor() {
    }

    setResults(results: Array<any>) {
        this.searchSubject.next(results);
    }

}
