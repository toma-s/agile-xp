import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { PublicTest } from './public-test.model';

@Injectable({
  providedIn: 'root'
})
export class PublicTestService {

  private baseUrl = `${environment.baseUrl}public-tests`;

  constructor(private http: HttpClient) { }

  createPublicTest(publicTest: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}` + `/create`, publicTest);
  }

  getPublicTestsByExerciseId(exerciseId: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/exercise/${exerciseId}`);
  }

  updatePublicTest(id: number, publicTest: PublicTest): Observable<any> {
    return this.http.put(`${this.baseUrl}/${id}`, publicTest);
  }

  deletePublicTestsByExerciseId(exerciseId: number) {
    return this.http.delete(`${this.baseUrl}/${exerciseId}`, { responseType: 'text'});
  }

}
