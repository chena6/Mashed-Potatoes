import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs/BehaviorSubject';

@Injectable()
export class RefreshService {

    private refresh = new BehaviorSubject<number>(0);
    observer = this.refresh.asObservable();
    val = 0;

    constructor() {}

    notify() {
        const newVal = this.val + 1;
        this.refresh.next(newVal);
    }
}
