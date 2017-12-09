import { Routes } from '@angular/router';

import { LandingPageComponent } from './components/landing/landing.component';
import { MovieDetailsComponent } from './components/movies/moviedetails/moviedetails.component';
import { SearchResultsComponent } from './components/movies/searchresults/searchresults.component';
import { UserDetailsComponent } from './components/users/userdetails/userdetails.component';

export const appRoutes: Routes = [
  { path: 'home', component: LandingPageComponent },
  { path: 'movies/:id', component: MovieDetailsComponent },
  { path: 'search', component: SearchResultsComponent },

  { path: 'users/:id', component: UserDetailsComponent },
];
