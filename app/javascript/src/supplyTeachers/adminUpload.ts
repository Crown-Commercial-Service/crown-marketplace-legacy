import { FileUploadProgressWithoutBar, type StateToProgressWithoutProgressBar } from '../shared/uploadProgress'

const supplyTeachersProcessingStateToProgress: StateToProgressWithoutProgressBar = {
  not_started: {
    wait: 1000,
    isFinished: false
  },
  processing_files: {
    wait: 5000,
    isFinished: false
  },
  files_processed: {
    wait: 0,
    isFinished: true
  },
  canceled: {
    wait: 0,
    isFinished: true
  },
  failed: {
    wait: 0,
    isFinished: true
  }
}

const supplyTeachersUploadingStateToProgress: StateToProgressWithoutProgressBar = {
  files_processed: {
    wait: 1000,
    isFinished: false
  },
  uploading: {
    wait: 5000,
    isFinished: false
  },
  published: {
    wait: 0,
    isFinished: true
  },
  canceled: {
    wait: 0,
    isFinished: true
  },
  failed: {
    wait: 0,
    isFinished: true
  }
}

const initSupplyTeachersAdminUpload = (): void => {
  const $supplyTeachersUploadState: JQuery<HTMLInputElement> = $('#supply_teachers_admin_upload_state')

  if ($supplyTeachersUploadState.length > 0) {
    if ($supplyTeachersUploadState.val() === 'processing_files') new FileUploadProgressWithoutBar(supplyTeachersProcessingStateToProgress, 'not_started')
    if ($supplyTeachersUploadState.val() === 'uploading') new FileUploadProgressWithoutBar(supplyTeachersUploadingStateToProgress, 'files_processed')
  }
}

export default initSupplyTeachersAdminUpload
