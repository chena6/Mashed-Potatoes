import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs/BehaviorSubject';

@Injectable()
export class BacklogService {

    private Backlog = new BehaviorSubject<any>(null);
    currentUserBacklog = this.Backlog.asObservable();

    constructor() {
    }

    setMovies(movies: any) {
        this.Backlog.next(movies);
    }

}