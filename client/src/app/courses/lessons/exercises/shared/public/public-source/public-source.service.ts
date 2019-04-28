import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { PublicSource } from './public-source.model';

@Injectable({
  providedIn: 'root'
})
export class PublicSourceService {

  private baseUrl = `${environment.baseUrl}public-sources`;

  constructor(private http: HttpClient) { }

  createPublicSource(publicSource: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}/create`, publicSource);
  }

  getPublicSourcesByExerciseId(exerciseId: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/exercise/${exerciseId}`);
  }

  updatePublicSource(id: number, publicSource: PublicSource): Observable<any> {
    return this.http.put(`${this.baseUrl}/${id}`, publicSource);
  }

  deletePublicSourcesByExerciseId(exerciseId: number) {
    return this.http.delete(`${this.baseUrl}/${exerciseId}`, { responseType: 'text'});
  }

}
