import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment.prod';

@Injectable({
  providedIn: 'root'
})
export class SolutonService {

  private baseUrl = `${environment.production}solutions`;

  constructor(private http: HttpClient) { }

  createSolution(solution: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}/create`, solution);
  }
}
