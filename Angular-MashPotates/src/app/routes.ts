import { Routes } from '@angular/router';

import { LandingPageComponent } from './components/landing/landing.component';
import { MovieDetailsComponent } from './components/moviedetails/moviedetails.component';
import { SearchResultsComponent } from './components/searchresults/searchresults.component';

export const appRoutes: Routes = [
  { path: 'home', component: LandingPageComponent },
  { path: 'movies/:id', component: MovieDetailsComponent },
  { path: 'search', component: SearchResultsComponent },
];
