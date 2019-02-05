export class TaskData {
    id: number;
    sourceFilename: string;
    testFilename: string;
    timestamp: Date;
    resultRunTime: number;
    resultSuccessful: boolean;
    resultRunCount: number;
    resultFailuresCount: number;
    resultFailures: string;
    resultIgnoreCount: number;
}
