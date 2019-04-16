import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class PublicFileService {

  private baseUrl = `${environment.baseUrl}public-file`;

  constructor(private http: HttpClient) { }

  createPublicFile(publicFile: Object): Observable<any> {
    return this.http.post(`${this.baseUrl}` + `/create`, publicFile);
  }

  getPublicFilesByExerciseId(exerciseId: number): Observable<any> {
    return this.http.get(`${this.baseUrl}/exercise/${exerciseId}`);
  }
}
