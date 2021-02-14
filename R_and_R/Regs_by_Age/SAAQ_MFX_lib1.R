


mfx_AME_diff <- function(saaq_data_pred, log_model_1) {

  # Calculate average prediction before policy change.
  saaq_data_pred[, 'policy'] <- FALSE
  saaq_data_pred[, 'pred_prob_before'] <- predict(log_model_1,
                                                  newdata = saaq_data_pred,
                                                  type="response")
  pred_before <- sum(saaq_data_pred[, 'pred_prob_before'] *
                       saaq_data_pred[, 'num']) / sum(saaq_data_pred[, 'num'])

  # Calculate average prediction after policy change.
  saaq_data_pred[, 'policy'] <- TRUE
  saaq_data_pred[, 'pred_prob_after'] <- predict(log_model_1,
                                                 newdata = saaq_data_pred,
                                                 type="response")
  pred_after <- sum(saaq_data_pred[, 'pred_prob_after'] *
                      saaq_data_pred[, 'num']) / sum(saaq_data_pred[, 'num'])

  # Assign difference to AME.
  mfx <- pred_after - pred_before

  return(mfx)

}




mfx_AME_cross_diff <- function(saaq_data_pred, log_model_1,
                               cross_coefficient) {

  # Calculate average prediction before policy change.
  saaq_data_pred[, 'policy'] <- FALSE
  saaq_data_pred[, 'pred_prob_before'] <- predict(log_model_1,
                                                  newdata = saaq_data_pred,
                                                  type="response")
  pred_before <- sum(saaq_data_pred[, 'pred_prob_before'] *
                       saaq_data_pred[, 'num']) / sum(saaq_data_pred[, 'num'])

  # Calculate average prediction after policy change.
  saaq_data_pred[, 'policy'] <- TRUE
  saaq_data_pred[, 'pred_prob_after'] <- predict(log_model_1,
                                                 newdata = saaq_data_pred,
                                                 type="response")
  pred_after <- sum(saaq_data_pred[, 'pred_prob_after'] *
                      saaq_data_pred[, 'num']) / sum(saaq_data_pred[, 'num'])

  # Assign difference to AME.
  mfx <- pred_after - pred_before

  return(mfx)
}
