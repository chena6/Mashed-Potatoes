import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs/BehaviorSubject';

@Injectable()
export class WatchedService {

    private Watched = new BehaviorSubject<any>(null);
    currentUserWatched = this.Watched.asObservable();

    constructor() {
    }

    setMovies(movies: any) {
        this.Watched.next(movies);
    }

}
